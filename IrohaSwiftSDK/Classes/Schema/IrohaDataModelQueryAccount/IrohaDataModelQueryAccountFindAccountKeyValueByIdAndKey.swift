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

extension IrohaDataModelQueryAccount {
    public struct FindAccountKeyValueByIdAndKey: Codable {
        
        public var id: IrohaDataModelExpression.EvaluatesTo
        public var key: IrohaDataModelExpression.EvaluatesTo
        
        public init(
            id: IrohaDataModelExpression.EvaluatesTo, 
            key: IrohaDataModelExpression.EvaluatesTo
        ) {
            self.id = id
            self.key = key
        }
    }
}