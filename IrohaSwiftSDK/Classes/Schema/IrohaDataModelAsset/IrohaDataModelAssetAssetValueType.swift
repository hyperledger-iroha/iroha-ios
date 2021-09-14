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
import IrohaSwiftScale

extension IrohaDataModelAsset {
    public indirect enum AssetValueType: Codable {
        
        case quantity
        case bigQuantity
        case fixed
        case store
        
        // MARK: - For Codable purpose
        
        static func discriminant(of case: Self) -> UInt8 {
            switch `case` {
                case .quantity:
                    return 0
                case .bigQuantity:
                    return 1
                case .fixed:
                    return 2
                case .store:
                    return 3
            }
        }
        
        // MARK: - Decodable
        
        public init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            let discriminant = try container.decode(UInt8.self)
            switch discriminant {
            case 0:
                
                self = .quantity
                break
            case 1:
                
                self = .bigQuantity
                break
            case 2:
                
                self = .fixed
                break
            case 3:
                
                self = .store
                break
            default:
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown discriminant \(discriminant)")
            }
        }
        
        // MARK: - Encodable
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.unkeyedContainer()
            try container.encode(AssetValueType.discriminant(of: self))
            switch self {
            case .quantity:
                
                break
            case .bigQuantity:
                
                break
            case .fixed:
                
                break
            case .store:
                
                break
            }
        }
    }
}