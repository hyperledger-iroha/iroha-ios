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

public struct IrohaKeyPair {
    public let publicKey: [UInt8]
    public let privateKey: [UInt8]
    
    public init(publicKey: [UInt8], privateKey: [UInt8]) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}

public struct IrohaAccount {
    public let keyPair: IrohaKeyPair
    public let id: IrohaDataModelAccount.Id
    
    public init(keyPair: IrohaKeyPair, id: IrohaDataModelAccount.Id) {
        self.keyPair = keyPair
        self.id = id
    }
}
