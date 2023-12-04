//
// Copyright 2021 Soramitsu Co., Ltd.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

struct File {
    let typeName: String
    let contents: String
}

struct SchemaConverter {
    
    enum Error: LocalizedError {
        case invalidSchema
    }
    
    private(set) var schema: [String: TypeMetadata]
    let fileManager: FileManager
    let importFrameworks: [String]
    private var namespacesWritten = Set<String>()
    
    init(schema: [String: TypeMetadata], fileManager: FileManager, importFrameworks: [String]) {
        self.schema = schema
        self.fileManager = fileManager
        self.importFrameworks = importFrameworks
    }
    
    mutating func convert() throws {
        unwrapNames()
        let namespacePaths = resolveNamespacePaths()
        for (typeMetadata, namespacePath) in namespacePaths {
            try write(typeMetadata: typeMetadata, namespacePath: namespacePath)
        }
        
        for file in Rules.finalize() {
            try write(companion: file)
        }
    }
}

// MARK: - Namespaces

private extension String {
    
    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
    
    var upperCamelCased: String {
        split(separator: "_").map { String($0).capitalizingFirstLetter }.joined()
    }
    
    var loweringFirstLetter: String {
        prefix(1).lowercased() + dropFirst()
    }
    
    var lowerCamelCased: String {
        upperCamelCased.loweringFirstLetter
    }
}

private protocol NamespaceResolver {
    func typeName(for: String) -> String
}

extension SchemaConverter: NamespaceResolver {
    
    private mutating func unwrapNames() {
        schema.forEach { name, metadata in
            let unwrappedName = unwrapTypeName(for: name)
            if unwrappedName != name, !Rules.typesIgnoringGeneric.contains(unwrappedName) {
                schema.removeValue(forKey: name)
            }
        }
    }
    
    private func resolveNamespacePaths() -> [(TypeMetadata, [String])] {
        var paths: [(TypeMetadata, [String])] = []
        for metadata in schema.values {
            // catch unique values
            if paths.contains(where: { $0.0.name == metadata.name }) {
                continue
            }
            
            if let resolved = resolveNamespacePath(typeMetadata: metadata).map({ (metadata, $0) }) {
                paths.append(resolved)
            }
        }
        
        return paths
    }
    
    private func resolveNamespacePath(typeMetadata: TypeMetadata) -> [String]? {
        switch typeMetadata.kind {
        case .struct, .tupleStruct, .enum, .fixedPoint, .fixedSizeArray:
            return namespacePath(for: typeMetadata.name)
        default:
            return nil
        }
    }
    
    private func nativeType(for name: String) -> String {
        switch name {
        case "u8": return "UInt8"
        case "u16": return "UInt16"
        case "u32": return "UInt32"
        case "u64": return "UInt64"
        case "u128": return "UInt128"
        case "i8": return "Int8"
        case "i16": return "Int16"
        case "i32": return "Int32"
        case "i64": return "Int64"
        case "bool": return "Bool"
        case "Vec": return "Array"
        case "Map", "BTreeMap": return "Dictionary"
        case "Set", "BTreeSet": return "Array" // consider Array for now, Set requires it to be hashable, which is hard for some types to implement atm
        default: return name
        }
    }
    
    private func namespacePath(for name: String) -> [String] {
        var name = name
        if let ignored = Rules.typesIgnoringGeneric.first(where: { name.starts(with: $0) }) {
            name = ignored
        }
        let parts = nativeType(for: name).components(separatedBy: "::")
        guard parts.count > 1 else { return [name] }
        return [parts.dropLast().map { $0.trimmingCharacters(in: .whitespacesAndNewlines).upperCamelCased }.joined(), parts.last!]
    }
    
    func typeName(for name: String) -> String {
        namespacePath(for: name).joined(separator: ".")
    }
    
    private func unwrapTypeName(for name: String) -> String {
        for type in Rules.typesIgnoringGeneric {
            if name.starts(with: type) {
                return type
            }
        }
        
        for type in Rules.ignoredWrappingTypes {
            if name.starts(with: type) {
                return name
                    .replacingOccurrences(of: type, with: "")
                    .replacingOccurrences(of: "<", with: "")
                    .replacingOccurrences(of: ">", with: "")
            }
        }
        
        return name
    }
}

// MARK: - Variable name fix

private protocol NameFixer {
    func fixVariableName(_ name: String) -> String
    func fixVariableType(_ name: String) throws -> String
}

extension SchemaConverter: NameFixer {
    func fixVariableName(_ name: String) -> String {
        let name = name.lowerCamelCased
        if Rules.keywords.contains(name) {
            return "`\(name)`"
        }
        
        return name
    }
    
    func fixVariableType(_ name: String) throws -> String {
        if name.starts(with: "["), name.hasSuffix("]"), name.contains(";") {
            let typeName = name.split(separator: ";")[0].dropFirst()
            let fixedSize = name.split(separator: ";")[1].dropLast().trimmingCharacters(in: .whitespaces)
            
            guard let fixedSize = UInt(fixedSize) else {
                throw Error.invalidSchema
            }
            
            let verbose = "\(Rules.fixedSizeArrayFactory.structName(size: fixedSize))<\(typeName)>"
            return try fixVariableType(verbose)
        }
        
        var genericType = TypeParser.genericType(for: name)
        if !genericType.parameters.isEmpty, Rules.typesIgnoringGeneric.contains(genericType.typeName) {
            genericType.parameters = []
        }
        
        return fix(genericType: genericType).description
    }
    
    private func fix(genericType: TypeParser.GenericType) -> TypeParser.GenericType {
        if genericType.typeName == "Option" && genericType.parameters.count == 1 {
            let typeName = typeName(for: nativeType(for: genericType.parameters[0].typeName))
            return TypeParser.GenericType(typeName: "\(typeName)?", parameters: [])
        }
        
        if Rules.ignoredWrappingTypes.contains(genericType.typeName) && genericType.parameters.count == 1 {
            let genericType = TypeParser.GenericType(typeName: genericType.parameters[0].typeName, parameters: genericType.parameters[0].parameters)
            return fix(genericType: genericType)
        }
        
        var genericType = genericType
        for rule in Rules.typesIgnoringGeneric {
            if genericType.typeName.starts(with: rule) {
                genericType.parameters = []
                break
            }
        }
        for rule in Rules.ignoredNamespaces {
            if genericType.typeName.starts(with: rule) {
                genericType.typeName = genericType.typeName.replacingOccurrences(of: rule, with: "")
                break
            }
        }
        
        genericType.typeName = typeName(for: nativeType(for: genericType.typeName))
        genericType.parameters = genericType.parameters.map { fix(genericType: $0) }
        
        return genericType
    }
}

private struct TypeParser {
    struct GenericType: CustomStringConvertible {
        var typeName: String
        var parameters: [GenericType]
        
        var description: String {
            if parameters.count == 0 {
                return typeName
            }
            
            if let shorteningParametersCount = Rules.shorteningTypes[typeName], shorteningParametersCount == parameters.count {
                return "\(Rules.shorteningBrackets[0])\(parameters.map { $0.description }.joined(separator: ": "))\(Rules.shorteningBrackets[1])"
            }
            
            return "\(typeName)<\(parameters.map { $0.description }.joined(separator: ", "))>"
        }
    }
    
    static func splitByComma(_ typeName: String) -> [String] {
        var strings: [String] = []
        var string = ""
        var level = 0
        
        var skip = false
        for char in typeName {
            if skip {
                skip = false
                continue
            }
            
            if char == "," && level == 0 {
                strings.append(string)
                string = ""
                skip = true
            } else {
                string.append(char)
            }
            
            if char == "<" {
                level += 1
            } else if char == ">" {
                level -= 1
            }
        }
        
        strings.append(string)
        
        return strings
    }
    
    static func genericType(for typeName: String) -> GenericType {
        if !typeName.contains("<") {
            return GenericType(typeName: typeName, parameters: [])
        }
        
        guard let start = typeName.firstIndex(of: "<") else {
            return GenericType(typeName: typeName, parameters: [])
        }
        
        let parametersList = String(typeName.suffix(from: typeName.index(after: start)).dropLast())
        let name = String(typeName.prefix(upTo: start))
        let parameters = splitByComma(parametersList).map { genericType(for: $0) }
        
        return GenericType(typeName: name, parameters: parameters)
    }
}

// MARK: - Writing

extension SchemaConverter {
    
    private var stubFilename: String { "NamespacesStub.\(Rules.fileExtension)" }
    
    private var fileHeader: String {
        var header = Rules.fileHeader + "\n"
        
        let importFrameworks = Rules.importFrameworks(from: importFrameworks)
        if importFrameworks.count > 0 {
            header += importFrameworks.sorted().map { "import \($0)" }.joined(separator: "\n")
            header += "\n"
        }
        
        return header
    }
    
    mutating private func write(companion file: File) throws {
        let fileName = file.typeName.appending(".\(Rules.fileExtension)")
        let body = fileHeader + file.contents
        
        try fileManager.writeFile(at: fileName, contents: body)
    }
    
    mutating private func write(typeMetadata: TypeMetadata, namespacePath: [String], isNamespace: Bool = false) throws {
        guard let typeName = namespacePath.last else {
            throw Error.invalidSchema
        }
        
        var filename = namespacePath.joined().appending(".\(Rules.fileExtension)")
        filename = (namespacePath.dropLast() + [filename]).joined(separator: "/")
        if isNamespace {
            filename = stubFilename
        }
        
        let hashable = namespacePath.count == 2 && Rules.hashable.contains(where: {
            $0.0 == namespacePath[0] && $0.1 == namespacePath[1]
        })
        
        guard let writer = Rules.typeWriter(for: typeMetadata, name: typeName, resolver: self, hashable: hashable, codable: !isNamespace) else {
            throw Error.invalidSchema
        }
        
        var header = fileHeader + "\n"
        
        var tabs = 0
        if isNamespace && namespacesWritten.count > 0 {
            header = ""
        }
        
        var footer = ""
        
        if namespacePath.count > 1, let namespace = namespacePath.first {
            footer = "\n}"
            header += "\(Rules.extensionKeyword) \(namespace) {\n"
            tabs = 1
            
            if !namespacesWritten.contains(namespace) {
                let metadata = TypeMetadata(name: namespace, kind: .struct([]))
                try write(typeMetadata: metadata, namespacePath: [namespace], isNamespace: true)
                namespacesWritten.insert(namespace)
            }
        }
        
        var body = try writer.write()
        if header.count > 0 || footer.count > 0 {
            let tab = tabs > 0 ?  Rules.tab(tabs) : ""
            body = body.split(separator: "\n").map { tab + $0 }.joined(separator: "\n")
            body = header.appending(body).appending(footer)
        }
        
        try fileManager.writeFile(at: filename, contents: body, append: isNamespace)
    }
}

// MARK: - Rules

private struct Rules {
    
    private static let defaultImportFrameworks: [String] = ["Foundation"]
    static func importFrameworks(from provided: [String]) -> [String] {
        provided + defaultImportFrameworks
    }
    
    static let fileHeader = """
    //
    // Copyright 2021 Soramitsu Co., Ltd.
    //
    // Licensed under the Apache License, Version 2.0 (the "License");
    // you may not use this file except in compliance with the License.
    // You may obtain a copy of the License at
    //
    //     http://www.apache.org/licenses/LICENSE-2.0
    //
    // Unless required by applicable law or agreed to in writing, software
    // distributed under the License is distributed on an "AS IS" BASIS,
    // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    // See the License for the specific language governing permissions and
    // limitations under the License.
    //
    
    """
    static let fileExtension = "swift"
    static let keywords = ["if", "where"]
    static let indirectKeyword: String? = "indirect"
    static let extensionKeyword = "extension"
    static let fixedPointType = "Decimal"
    static let fixedPointDecimalPlacesType = "Int16"
    private static let tab = "    "
    static func tab(_ count: Int = 1) -> String { [String](repeating: tab, count: count).joined(separator: "") }
    static let ignoredWrappingTypes: [String] = [
//        "iroha_data_model::expression::EvaluatesTo",
    ]
    static let typesIgnoringGeneric = [
        "iroha_data_model::expression::EvaluatesTo",
        "FixedPoint"
    ]
    static let ignoredNamespaces = [
        "alloc::string::",
        "alloc::vec::",
        "iroha_schema::",
    ]
    static let shorteningBrackets = ["[", "]"]
    static let shorteningTypes = [
        "Array": 1,
        "Dictionary": 2,
    ]
    static let hashable = [
        ("IrohaDataModelAsset", "Id"),
        ("IrohaDataModelAsset", "DefinitionId"),
        ("IrohaDataModelAccount", "Id"),
    ]
    
    private static var tupleStructFactory = TupleStructFactory()
    fileprivate static var fixedSizeArrayFactory = FixedSizeArrayFactory()
    
    static func typeWriter(
        for typeMetadata: TypeMetadata,
        name: String,
        resolver: NamespaceResolver & NameFixer,
        hashable: Bool,
        codable: Bool = true
    ) -> TypeWriter? {
        
        switch typeMetadata.kind {
        case let .struct(fields):
            return StructWriter(name: name, fields: fields, resolver: resolver, hashable: hashable, codable: codable)
        case let .tupleStruct(types):
            return TupleStructWriter(name: name, types: types, resolver: resolver, factory: tupleStructFactory)
        case let .enum(cases):
            return EnumWriter(name: name, cases: cases, resolver: resolver)
        case let .fixedPoint(kind, decimalPlaces):
            return FixedPointWriter(kind: kind, decimalPlaces: decimalPlaces, resolver: resolver)
        case let .fixedSizeArray(_, size):
            return FixedSizeArrayWriter(size: size, factory: fixedSizeArrayFactory)
        default: return nil
        }
    }
    
    static func finalize() -> [File] {
        // FixedSizeArray are declared in root of schema and are separate types,
        // while TupleStruct types even though declared in root of schema,
        // factory provided helper files are separate files, thus needed to be written
        tupleStructFactory.files
    }
}

// MARK: - Writers

private protocol TypeWriter {
    func write() throws -> String
}

private func writeInterfaces(_ interfaces: [String]) -> String {
    if interfaces.isEmpty {
        return ""
    }
    
    return ": " + interfaces.joined(separator: ", ")
}

private struct StructWriter: TypeWriter {
    
    let name: String
    let fields: [(String, String)]
    let resolver: NamespaceResolver & NameFixer
    let hashable: Bool
    let codable: Bool
    
    private func writeField(_ variable: (String, String)) -> String {
        "\(Rules.tab())public var \(variable.0): \(variable.1)"
    }
    
    private func writeConstructor(variables: [(String, String)]) -> String {
        """
        \(Rules.tab())public init(\(variables.count > 1 ? "\n\(Rules.tab(2))" : "")\(variables.map { "\($0): \($1)" }.joined(separator: ",\(variables.count > 1 ? "\n\(Rules.tab(2))" : "")"))\(variables.count > 1 ? "\n\(Rules.tab())" : "")) {
        \(Rules.tab())\(variables.map { "\(Rules.tab())self.\($0.0) = \($0.0)" }.joined(separator: "\n\(Rules.tab())"))
        \(Rules.tab())}
        """
    }
    
    private func hashableBody(variables: [(String, String)]) -> String {
        if !hashable {
            return ""
        }
        
        return """
        \(Rules.tab())
        // MARK: - Hashable
        \(Rules.tab())
        public func hash(into hasher: inout Hasher) {
        \(Rules.tab())\(variables.map { "hasher.combine(\($0.0))" }.joined(separator: "\n\(Rules.tab())"))
        }
        """.split(separator: "\n").map { "\(Rules.tab())\($0)" }.joined(separator: "\n")
    }
    
    func write() throws -> String {
        var interfaces = codable ? ["Swift.Codable"] : []
        if fields.count == 0 {
            if codable {
                return """
                public struct \(name)\(writeInterfaces(interfaces)) {
                \(Rules.tab())public init() {}
                }
                """
            } else {
                return "public struct \(name)\(writeInterfaces(interfaces)) {}"
            }
        }
        
        let variables = try fields.map {
            (resolver.fixVariableName($0.0), try resolver.fixVariableType($0.1))
        }
        
        if hashable {
            interfaces.append("Hashable")
        }
        
        return """
        public struct \(name)\(writeInterfaces(interfaces)) {
        \(Rules.tab())
        \(variables.map { writeField($0) }.joined(separator: "\n"))
        \(Rules.tab())
        \(writeConstructor(variables: variables))
        \(hashableBody(variables: variables))
        }
        """
    }
}

private struct FixedSizeArrayWriter: TypeWriter {
    let size: UInt
    let factory: FixedSizeArrayFactory
    
    func write() throws -> String {
        try factory.make(size: size)
    }
}

private struct FixedPointWriter: TypeWriter {
    
    let kind: String
    let decimalPlaces: UInt
    let resolver: NameFixer
    
    private func typeName() throws -> String { try resolver.fixVariableType(kind) }
    
    func write() throws -> String {
        """
        // MARK: - Extensions
        \(Rules.tab())
        private extension NSDecimalNumber {
        \(Rules.tab())static func roundingBehavior(scale: Int16) -> NSDecimalNumberBehaviors {
        \(Rules.tab(2))NSDecimalNumberHandler(
        \(Rules.tab(3))roundingMode: .plain,
        \(Rules.tab(3))scale: scale,
        \(Rules.tab(3))raiseOnExactness: false,
        \(Rules.tab(3))raiseOnOverflow: false,
        \(Rules.tab(3))raiseOnUnderflow: false,
        \(Rules.tab(3))raiseOnDivideByZero: false
        \(Rules.tab(2)))
        \(Rules.tab())}
        }
        \(Rules.tab())
        private extension \(Rules.fixedPointType) {
        \(Rules.tab())init(base: \(try typeName()), decimalPlaces: \(Rules.fixedPointDecimalPlacesType)) {
        \(Rules.tab(2))self = NSDecimalNumber(value: base).multiplying(byPowerOf10: -decimalPlaces) as \(Rules.fixedPointType)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())func to\(try typeName())(decimalPlaces: \(Rules.fixedPointDecimalPlacesType)) throws -> \(try typeName()) {
        \(Rules.tab(2))let multiplied = (self as NSDecimalNumber)
        \(Rules.tab(3)).multiplying(byPowerOf10: decimalPlaces, withBehavior: NSDecimalNumber.roundingBehavior(scale: decimalPlaces))
        \(Rules.tab())
        \(Rules.tab(2))guard (multiplied as Decimal) <= Decimal(Int64.max) else {
        \(Rules.tab(3))throw FixedPoint.Error.decimalValueTooHigh
        \(Rules.tab(2))}
        \(Rules.tab())
        \(Rules.tab(2))return multiplied.\(try typeName().loweringFirstLetter)Value
        \(Rules.tab())}
        }
        // MARK: - FixedPoint
        \(Rules.tab())
        public struct FixedPoint {
        \(Rules.tab())
        \(Rules.tab())enum Error: Swift.Error {
        \(Rules.tab(2))case decimalValueTooHigh
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static let decimalPlaces: \(Rules.fixedPointDecimalPlacesType) = \(decimalPlaces)
        \(Rules.tab())
        \(Rules.tab())public private(set) var base: \(try typeName())
        \(Rules.tab())
        \(Rules.tab())public var value: \(Rules.fixedPointType) {
        \(Rules.tab(2))get { \(Rules.fixedPointType)(base: base, decimalPlaces: Self.decimalPlaces) }
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public init(base: \(try typeName())) {
        \(Rules.tab(2))self.base = base
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public init(value: \(Rules.fixedPointType)) throws {
        \(Rules.tab(2))self.base = try value.to\(try typeName())(decimalPlaces: Self.decimalPlaces)
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - Codable
        \(Rules.tab())
        extension FixedPoint: Swift.Codable {
        \(Rules.tab())public init(from decoder: Swift.Decoder) throws {
        \(Rules.tab(2))self.base = try decoder.singleValueContainer().decode(\(try typeName()).self)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public func encode(to encoder: Encoder) throws {
        \(Rules.tab(2))var container = encoder.singleValueContainer()
        \(Rules.tab(2))try container.encode(base)
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - Comparable
        \(Rules.tab())
        extension FixedPoint: Comparable {
        \(Rules.tab())public static func == (lhs: FixedPoint, rhs: FixedPoint) -> Bool {
        \(Rules.tab(2))lhs.base == rhs.base
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func < (lhs: FixedPoint, rhs: FixedPoint) -> Bool {
        \(Rules.tab(2))lhs.base < rhs.base
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - AdditiveArithmetic
        \(Rules.tab())
        extension FixedPoint: AdditiveArithmetic {
        \(Rules.tab())public static var zero: FixedPoint {
        \(Rules.tab(2)).init(base: 0)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func - (lhs: FixedPoint, rhs: FixedPoint) -> FixedPoint {
        \(Rules.tab(2)).init(base: lhs.base - rhs.base)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func + (lhs: FixedPoint, rhs: FixedPoint) -> FixedPoint {
        \(Rules.tab(2)).init(base: lhs.base + rhs.base)
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - SignedNumeric
        \(Rules.tab())
        extension FixedPoint: SignedNumeric {
        \(Rules.tab())public var magnitude: Decimal {
        \(Rules.tab(2))value.magnitude
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public init?<T>(exactly source: T) where T : BinaryInteger {
        \(Rules.tab(2))guard let base = try? Decimal(exactly: source)?.toInt64(decimalPlaces: Self.decimalPlaces) else {
        \(Rules.tab(3))return nil
        \(Rules.tab(2))}
        \(Rules.tab())
        \(Rules.tab(2))self.base = base
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public init(integerLiteral value: Int) {
        \(Rules.tab(2))// Int value won't exceed Int64.max limit, so we can force unwrap
        \(Rules.tab(2))self.base = try! Decimal(value).toInt64(decimalPlaces: Self.decimalPlaces)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func * (lhs: FixedPoint, rhs: FixedPoint) -> FixedPoint {
        \(Rules.tab(2)).init(base: lhs.base * rhs.base)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func *= (lhs: inout FixedPoint, rhs: FixedPoint) {
        \(Rules.tab(2))lhs.base *= rhs.base
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func / (lhs: FixedPoint, rhs: FixedPoint) -> FixedPoint {
        \(Rules.tab(2))// Both values are correct fixed points, can be forced
        \(Rules.tab(2)).init(base: try! (lhs.value / rhs.value).toInt64(decimalPlaces: Self.decimalPlaces))
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func /= (lhs: inout FixedPoint, rhs: FixedPoint) {
        \(Rules.tab(2))// Both values are correct fixed points, can be forced
        \(Rules.tab(2))lhs.base = try! (lhs.value / rhs.value).toInt64(decimalPlaces: Self.decimalPlaces)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func += (lhs: inout FixedPoint, rhs: FixedPoint) {
        \(Rules.tab(2))lhs.base += rhs.base
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static func -= (lhs: inout FixedPoint, rhs: FixedPoint) {
        \(Rules.tab(2))lhs.base -= rhs.base
        \(Rules.tab())}
        }
        """
    }
}

private struct TupleStructWriter: TypeWriter {
    
    let name: String
    let types: [String]
    let resolver: NamespaceResolver & NameFixer
    let factory: TupleStructFactory
    
    func write() throws -> String {
        if types.isEmpty {
            // Empty tuples doesn't work with Codable, so let's use empty struct
            return try StructWriter(name: name, fields: [], resolver: resolver, hashable: false, codable: true).write()
        }
        
        if types.count == 1 {
            return "public typealias \(name) = (\(try types.map { try resolver.fixVariableType($0) }.joined(separator: ", ")))"
        }
        
        let count = UInt(types.count)
        let typeName = factory.structName(size: count)
        try factory.make(size: UInt(types.count))
        
        return "public typealias \(name) = \(typeName)<\(try types.map { try resolver.fixVariableType($0) }.joined(separator: ", "))>"
    }
}

private struct EnumWriter: TypeWriter {
    
    typealias Case = (String, UInt8, [String]?) // Name, Discriminant, Types
    
    let name: String
    let cases: [Case]
    let resolver: NamespaceResolver & NameFixer
    
    private func writeCase(_ case: Case) throws -> String {
        var string = "\(Rules.tab())case \(resolver.fixVariableName(`case`.0))"
        if let values = `case`.2 {
            string += "(\(try values.map { try resolver.fixVariableType($0) }.joined(separator: ", ")))"
        }
        
        return string
    }
    
    private func writeCaseDiscriminantGetter(_ case: Case) -> String {
        """
        \(Rules.tab(2))case .\(resolver.fixVariableName(`case`.0)):
        \(Rules.tab(3))return \(`case`.1)
        """
    }
    
    private func writeScaleEnumIterableConformance() -> String {
        """
        \(Rules.tab())// MARK: - For Codable purpose
        \(Rules.tab())
        \(Rules.tab())static func discriminant(of case: Self) -> UInt8 {
        \(Rules.tab(2))switch `case` {
        \(cases.map { writeCaseDiscriminantGetter($0) }.joined(separator: "\n"))
        \(Rules.tab(2))}
        \(Rules.tab())}
        """
    }
    
    private func writeCaseInit(_ case: Case) throws -> String {
        """
        \(Rules.tab(2))case \(`case`.1):
        \(Rules.tab(3))\(try `case`.2.map { "\(try $0.enumerated().map { "let val\($0.offset) = try container.decode(\(try resolver.fixVariableType($0.element)).self)" }.joined(separator: "\n"))" } ?? "")
        \(Rules.tab(3))self = .\(resolver.fixVariableName(`case`.0))\(`case`.2.map { "(\($0.enumerated().map { "val\($0.offset)" }.joined(separator: ", ")))" } ?? "")
        \(Rules.tab(3))break
        """
    }
    
    private func writeInitWithDecoder() throws -> String {
        """
        \(Rules.tab())// MARK: - Decodable
        \(Rules.tab())
        \(Rules.tab())public init(from decoder: Swift.Decoder) throws {
        \(Rules.tab(2))var container = try decoder.unkeyedContainer()
        \(Rules.tab(2))let discriminant = try container.decode(UInt8.self)
        \(Rules.tab(2))switch discriminant {
        \(try cases.map { try writeCaseInit($0) }.joined(separator: "\n"))
        \(Rules.tab(2))default:
        \(Rules.tab(3))throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown discriminant \\(discriminant)")
        \(Rules.tab(2))}
        \(Rules.tab())}
        """
    }
    
    private func writeCaseEncode(_ case: Case) -> String {
        """
        \(Rules.tab(2))case \(`case`.2 != nil ? "let " : "").\(resolver.fixVariableName(`case`.0))\(`case`.2.map { "(\($0.enumerated().map { "val\($0.offset)" }.joined(separator: ", ")))" } ?? ""):
        \(Rules.tab(3))\(`case`.2.map { $0.enumerated().map { "try container.encode(val\($0.offset))" }.joined(separator: "\n") } ?? "")
        \(Rules.tab(3))break
        """
    }
    
    private func writeEncode() -> String {
        """
        \(Rules.tab())// MARK: - Encodable
        \(Rules.tab())
        \(Rules.tab())public func encode(to encoder: Encoder) throws {
        \(Rules.tab(2))var container = encoder.unkeyedContainer()
        \(Rules.tab(2))try container.encode(\(name).discriminant(of: self))
        \(Rules.tab(2))switch self {
        \(cases.map { writeCaseEncode($0) }.joined(separator: "\n"))
        \(Rules.tab(2))}
        \(Rules.tab())}
        """
    }
    
    func write() throws -> String {
        // It's too complicated to calculate if enum can chainly call itself, so let's declare all enums indirect by default
        """
        public \(Rules.indirectKeyword.map { $0.appending(" ") } ?? "")enum \(name)\(writeInterfaces(["Swift.Codable"])) {

        \(try cases.map { try writeCase($0) }.joined(separator: "\n"))
        \(Rules.tab())
        \(writeScaleEnumIterableConformance())
        \(Rules.tab())
        \(try writeInitWithDecoder())
        \(Rules.tab())
        \(writeEncode())
        }
        """
    }
}

open class SizedStructFactory {
    enum Error: LocalizedError {
        case invalidVarsCount
        var errorDescription: String? { "Variables count should be > 1" }
    }
    
    private var filesByCount: [UInt: File] = [:]
    var files: [File] { filesByCount.values.map { $0 } }
    
    open func structName(size: UInt) -> String {
        fatalError("Not implemented")
    }
    
    open func write(size: UInt) throws -> String {
        fatalError("Not implemented")
    }
    
    @discardableResult
    func make(size: UInt) throws -> String {
        let structName = structName(size: size)
        guard filesByCount[size] == nil else {
            return structName
        }
        
        let file = try write(size: size)
        filesByCount[size] = File(typeName: structName, contents: file)
        return file
    }
}

private final class TupleStructFactory: SizedStructFactory {
    
    private func writeGenerics(varsCount: UInt) -> String {
        (1...varsCount).map { "T\($0): Swift.Codable" }.joined(separator: ", ")
    }
    
    private func writeTupleVar(count: UInt) -> String {
        """
        \(Rules.tab())public var tuple: (\((1...count).map { "T\($0)" }.joined(separator: ", "))) {
        \(Rules.tab(2))get { (\((0..<count).map { "_\($0)" }.joined(separator: ", "))) }
        \(Rules.tab(2))set {
        \((0..<count).map { Rules.tab(3) + "_\($0) = newValue.\($0)" }.joined(separator: "\n"))
        \(Rules.tab(2))}
        \(Rules.tab())}
        """
    }
    
    /// Required to ignore tuple var
    private func writeCodingKeys(varsCount: UInt) -> String {
        """
        \(Rules.tab())/// Ignore tuple var
        \(Rules.tab())private enum CodingKeys: String, CodingKey {
        \(Rules.tab(2))case \((0..<varsCount).map { "_\($0)" }.joined(separator: ", "))
        \(Rules.tab())}
        """
    }
    
    private func writeVariables(count: UInt) -> String {
        (1...count).map { Rules.tab() + "public var _\($0-1): T\($0)" }.joined(separator: "\n")
    }
    
    private func writeInit(varsCount: UInt) -> String {
        """
        \(Rules.tab())public init(\((1...varsCount).map { "_ _\($0-1): T\($0)" }.joined(separator: ", "))) {
        \((0..<varsCount).map { Rules.tab(2) + "self._\($0) = _\($0)" }.joined(separator: "\n"))
        \(Rules.tab())}
        """
    }
    
    override func structName(size: UInt) -> String {
        "Tuple\(size)"
    }
    
    override func write(size: UInt) throws -> String {
        guard size > 1 else {
            throw Error.invalidVarsCount
        }
        
        return """
        \(Rules.tab())
        public struct \(structName(size: size))<\(writeGenerics(varsCount: size))>: Swift.Codable {
        \(Rules.tab())
        \(writeCodingKeys(varsCount: size))
        \(Rules.tab())
        \(writeTupleVar(count: size))
        \(Rules.tab())
        \(writeVariables(count: size))
        \(Rules.tab())
        \(writeInit(varsCount: size))
        }
        """
    }
}

private final class FixedSizeArrayFactory: SizedStructFactory {
    override func structName(size: UInt) -> String {
        "Array\(size)"
    }
    
    override func write(size: UInt) throws -> String {
        """
        private let arraySize = \(size)
        \(Rules.tab())
        // MARK: Array\(size)
        \(Rules.tab())
        public struct Array\(size)<Element: Swift.Codable> {
        \(Rules.tab())
        \(Rules.tab())enum Error: LocalizedError {
        \(Rules.tab(2))case invalidInputSequenceLength(Int, Int)
        \(Rules.tab())
        \(Rules.tab(2))var errorDescription: String? {
        \(Rules.tab(3))switch self {
        \(Rules.tab(3))case let .invalidInputSequenceLength(providedSize, requiredSize):
        \(Rules.tab(4))return "Invalid input sequence length: \\(providedSize), length should be: \\(requiredSize)"
        \(Rules.tab(2))}
                }
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public static var fixedSize: Int { arraySize }
        \(Rules.tab())
        \(Rules.tab())private var array: Array<Element>
        \(Rules.tab())
        \(Rules.tab())public init<S: Sequence>(_ sequence: S) throws where S.Iterator.Element == Element {
        \(Rules.tab(2))let array = sequence.map { $0 }
        \(Rules.tab(2))guard array.count == arraySize else { throw Error.invalidInputSequenceLength(arraySize, array.count) }
        \(Rules.tab(2))self.array = array
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - Equatable
        \(Rules.tab())
        extension Array\(size): Equatable where Element: Equatable {
        \(Rules.tab())public static func ==(lhs: Array\(size), rhs: Array\(size)) -> Bool {
        \(Rules.tab(2))lhs.array == rhs.array
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - CustomStringConvertible
        \(Rules.tab())
        extension Array\(size): CustomStringConvertible {
        \(Rules.tab())public var description: String { array.description }
        }
        \(Rules.tab())
        // MARK: - Sequence
        \(Rules.tab())
        extension Array\(size): Sequence {
        \(Rules.tab())public typealias Iterator = IndexingIterator<Array<Element>>
        \(Rules.tab())
        \(Rules.tab())public func makeIterator() -> Iterator {
        \(Rules.tab(2))array.makeIterator()
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - Collection
        \(Rules.tab())
        extension Array\(size): Collection {
        \(Rules.tab())public typealias Index = Array<Element>.Index
        \(Rules.tab())
        \(Rules.tab())public var startIndex: Index { array.startIndex }
        \(Rules.tab())public var endIndex: Index { array.endIndex }
        \(Rules.tab())
        \(Rules.tab())public subscript(position: Index) -> Element {
        \(Rules.tab(2))get { array[position] }
        \(Rules.tab(2))set { array[position] = newValue }
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public func index(after i: Index) -> Index {
        \(Rules.tab(2))array.index(after: i)
        \(Rules.tab())}
        }
        \(Rules.tab())
        // MARK: - Codable
        \(Rules.tab())
        extension Array\(size): Swift.Codable {
        \(Rules.tab())public init(from decoder: Swift.Decoder) throws {
        \(Rules.tab(2))var container = try decoder.unkeyedContainer()
        \(Rules.tab(2))let array = try (0..<arraySize).map { _ in try container.decode(Element.self) }
        \(Rules.tab(2))try self.init(array)
        \(Rules.tab())}
        \(Rules.tab())
        \(Rules.tab())public func encode(to encoder: Encoder) throws {
        \(Rules.tab(2))var container = encoder.unkeyedContainer()
        \(Rules.tab(2))for element in array {
        \(Rules.tab(3))try container.encode(element)
        \(Rules.tab(2))}
        \(Rules.tab())}
        }
        """
    }
}
