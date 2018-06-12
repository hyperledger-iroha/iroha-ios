// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: block.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Iroha_Protocol_Header {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var createdTime: UInt64 = 0

  var signatures: [Iroha_Protocol_Signature] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Iroha_Protocol_Transaction {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var payload: Iroha_Protocol_Transaction.Payload {
    get {return _storage._payload ?? Iroha_Protocol_Transaction.Payload()}
    set {_uniqueStorage()._payload = newValue}
  }
  /// Returns true if `payload` has been explicitly set.
  var hasPayload: Bool {return _storage._payload != nil}
  /// Clears the value of `payload`. Subsequent reads from it will return its default value.
  mutating func clearPayload() {_storage._payload = nil}

  var signatures: [Iroha_Protocol_Signature] {
    get {return _storage._signatures}
    set {_uniqueStorage()._signatures = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  struct Payload {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var commands: [Iroha_Protocol_Command] = []

    var creatorAccountID: String = String()

    var createdTime: UInt64 = 0

    var quorum: UInt32 = 0

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Iroha_Protocol_Block {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var payload: Iroha_Protocol_Block.Payload {
    get {return _storage._payload ?? Iroha_Protocol_Block.Payload()}
    set {_uniqueStorage()._payload = newValue}
  }
  /// Returns true if `payload` has been explicitly set.
  var hasPayload: Bool {return _storage._payload != nil}
  /// Clears the value of `payload`. Subsequent reads from it will return its default value.
  mutating func clearPayload() {_storage._payload = nil}

  var signatures: [Iroha_Protocol_Signature] {
    get {return _storage._signatures}
    set {_uniqueStorage()._signatures = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// everything that should be signed:
  struct Payload {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var transactions: [Iroha_Protocol_Transaction] = []

    /// the number of transactions inside. Maximum 16384 or 2^14
    var txNumber: UInt32 = 0

    /// the current block number in a ledger
    var height: UInt64 = 0

    /// Previous block hash
    var prevBlockHash: Data = SwiftProtobuf.Internal.emptyData

    var createdTime: UInt64 = 0

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "iroha.protocol"

extension Iroha_Protocol_Header: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Header"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "created_time"),
    2: .same(proto: "signatures"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt64Field(value: &self.createdTime)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.signatures)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.createdTime != 0 {
      try visitor.visitSingularUInt64Field(value: self.createdTime, fieldNumber: 1)
    }
    if !self.signatures.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.signatures, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Iroha_Protocol_Header) -> Bool {
    if self.createdTime != other.createdTime {return false}
    if self.signatures != other.signatures {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Iroha_Protocol_Transaction: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Transaction"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "payload"),
    2: .same(proto: "signatures"),
  ]

  fileprivate class _StorageClass {
    var _payload: Iroha_Protocol_Transaction.Payload? = nil
    var _signatures: [Iroha_Protocol_Signature] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _payload = source._payload
      _signatures = source._signatures
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._payload)
        case 2: try decoder.decodeRepeatedMessageField(value: &_storage._signatures)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._payload {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if !_storage._signatures.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._signatures, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Iroha_Protocol_Transaction) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._payload != other_storage._payload {return false}
        if _storage._signatures != other_storage._signatures {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Iroha_Protocol_Transaction.Payload: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Iroha_Protocol_Transaction.protoMessageName + ".Payload"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "commands"),
    2: .standard(proto: "creator_account_id"),
    3: .standard(proto: "created_time"),
    4: .same(proto: "quorum"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.commands)
      case 2: try decoder.decodeSingularStringField(value: &self.creatorAccountID)
      case 3: try decoder.decodeSingularUInt64Field(value: &self.createdTime)
      case 4: try decoder.decodeSingularUInt32Field(value: &self.quorum)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.commands.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.commands, fieldNumber: 1)
    }
    if !self.creatorAccountID.isEmpty {
      try visitor.visitSingularStringField(value: self.creatorAccountID, fieldNumber: 2)
    }
    if self.createdTime != 0 {
      try visitor.visitSingularUInt64Field(value: self.createdTime, fieldNumber: 3)
    }
    if self.quorum != 0 {
      try visitor.visitSingularUInt32Field(value: self.quorum, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Iroha_Protocol_Transaction.Payload) -> Bool {
    if self.commands != other.commands {return false}
    if self.creatorAccountID != other.creatorAccountID {return false}
    if self.createdTime != other.createdTime {return false}
    if self.quorum != other.quorum {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Iroha_Protocol_Block: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Block"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "payload"),
    2: .same(proto: "signatures"),
  ]

  fileprivate class _StorageClass {
    var _payload: Iroha_Protocol_Block.Payload? = nil
    var _signatures: [Iroha_Protocol_Signature] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _payload = source._payload
      _signatures = source._signatures
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularMessageField(value: &_storage._payload)
        case 2: try decoder.decodeRepeatedMessageField(value: &_storage._signatures)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._payload {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if !_storage._signatures.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._signatures, fieldNumber: 2)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Iroha_Protocol_Block) -> Bool {
    if _storage !== other._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((_storage, other._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let other_storage = _args.1
        if _storage._payload != other_storage._payload {return false}
        if _storage._signatures != other_storage._signatures {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension Iroha_Protocol_Block.Payload: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = Iroha_Protocol_Block.protoMessageName + ".Payload"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "transactions"),
    2: .standard(proto: "tx_number"),
    3: .same(proto: "height"),
    5: .standard(proto: "prev_block_hash"),
    6: .standard(proto: "created_time"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.transactions)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.txNumber)
      case 3: try decoder.decodeSingularUInt64Field(value: &self.height)
      case 5: try decoder.decodeSingularBytesField(value: &self.prevBlockHash)
      case 6: try decoder.decodeSingularUInt64Field(value: &self.createdTime)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.transactions.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.transactions, fieldNumber: 1)
    }
    if self.txNumber != 0 {
      try visitor.visitSingularUInt32Field(value: self.txNumber, fieldNumber: 2)
    }
    if self.height != 0 {
      try visitor.visitSingularUInt64Field(value: self.height, fieldNumber: 3)
    }
    if !self.prevBlockHash.isEmpty {
      try visitor.visitSingularBytesField(value: self.prevBlockHash, fieldNumber: 5)
    }
    if self.createdTime != 0 {
      try visitor.visitSingularUInt64Field(value: self.createdTime, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Iroha_Protocol_Block.Payload) -> Bool {
    if self.transactions != other.transactions {return false}
    if self.txNumber != other.txNumber {return false}
    if self.height != other.height {return false}
    if self.prevBlockHash != other.prevBlockHash {return false}
    if self.createdTime != other.createdTime {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
