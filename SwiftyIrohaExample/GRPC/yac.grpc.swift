//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: yac.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
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
import Dispatch
import SwiftGRPC
import SwiftProtobuf

internal protocol Iroha_Consensus_Yac_Proto_YacSendVoteCall: ClientCallUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendVoteCallBase: ClientCallUnaryBase<Iroha_Consensus_Yac_Proto_Vote, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendVoteCall {
  override class var method: String { return "/iroha.consensus.yac.proto.Yac/SendVote" }
}

internal protocol Iroha_Consensus_Yac_Proto_YacSendCommitCall: ClientCallUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendCommitCallBase: ClientCallUnaryBase<Iroha_Consensus_Yac_Proto_Commit, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendCommitCall {
  override class var method: String { return "/iroha.consensus.yac.proto.Yac/SendCommit" }
}

internal protocol Iroha_Consensus_Yac_Proto_YacSendRejectCall: ClientCallUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendRejectCallBase: ClientCallUnaryBase<Iroha_Consensus_Yac_Proto_Reject, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendRejectCall {
  override class var method: String { return "/iroha.consensus.yac.proto.Yac/SendReject" }
}


/// Instantiate Iroha_Consensus_Yac_Proto_YacServiceClient, then call methods of this protocol to make API calls.
internal protocol Iroha_Consensus_Yac_Proto_YacService: ServiceClient {
  /// Synchronous. Unary.
  func sendVote(_ request: Iroha_Consensus_Yac_Proto_Vote) throws -> SwiftProtobuf.Google_Protobuf_Empty
  /// Asynchronous. Unary.
  func sendVote(_ request: Iroha_Consensus_Yac_Proto_Vote, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendVoteCall

  /// Synchronous. Unary.
  func sendCommit(_ request: Iroha_Consensus_Yac_Proto_Commit) throws -> SwiftProtobuf.Google_Protobuf_Empty
  /// Asynchronous. Unary.
  func sendCommit(_ request: Iroha_Consensus_Yac_Proto_Commit, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendCommitCall

  /// Synchronous. Unary.
  func sendReject(_ request: Iroha_Consensus_Yac_Proto_Reject) throws -> SwiftProtobuf.Google_Protobuf_Empty
  /// Asynchronous. Unary.
  func sendReject(_ request: Iroha_Consensus_Yac_Proto_Reject, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendRejectCall

}

internal final class Iroha_Consensus_Yac_Proto_YacServiceClient: ServiceClientBase, Iroha_Consensus_Yac_Proto_YacService {
  /// Synchronous. Unary.
  internal func sendVote(_ request: Iroha_Consensus_Yac_Proto_Vote) throws -> SwiftProtobuf.Google_Protobuf_Empty {
    return try Iroha_Consensus_Yac_Proto_YacSendVoteCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func sendVote(_ request: Iroha_Consensus_Yac_Proto_Vote, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendVoteCall {
    return try Iroha_Consensus_Yac_Proto_YacSendVoteCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func sendCommit(_ request: Iroha_Consensus_Yac_Proto_Commit) throws -> SwiftProtobuf.Google_Protobuf_Empty {
    return try Iroha_Consensus_Yac_Proto_YacSendCommitCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func sendCommit(_ request: Iroha_Consensus_Yac_Proto_Commit, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendCommitCall {
    return try Iroha_Consensus_Yac_Proto_YacSendCommitCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func sendReject(_ request: Iroha_Consensus_Yac_Proto_Reject) throws -> SwiftProtobuf.Google_Protobuf_Empty {
    return try Iroha_Consensus_Yac_Proto_YacSendRejectCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func sendReject(_ request: Iroha_Consensus_Yac_Proto_Reject, completion: @escaping (SwiftProtobuf.Google_Protobuf_Empty?, CallResult) -> Void) throws -> Iroha_Consensus_Yac_Proto_YacSendRejectCall {
    return try Iroha_Consensus_Yac_Proto_YacSendRejectCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
/// If one of the methods returning `ServerStatus?` returns nil,
/// it is expected that you have already returned a status to the client by means of `session.close`.
internal protocol Iroha_Consensus_Yac_Proto_YacProvider {
  func sendVote(request: Iroha_Consensus_Yac_Proto_Vote, session: Iroha_Consensus_Yac_Proto_YacSendVoteSession) throws -> SwiftProtobuf.Google_Protobuf_Empty
  func sendCommit(request: Iroha_Consensus_Yac_Proto_Commit, session: Iroha_Consensus_Yac_Proto_YacSendCommitSession) throws -> SwiftProtobuf.Google_Protobuf_Empty
  func sendReject(request: Iroha_Consensus_Yac_Proto_Reject, session: Iroha_Consensus_Yac_Proto_YacSendRejectSession) throws -> SwiftProtobuf.Google_Protobuf_Empty
}

internal protocol Iroha_Consensus_Yac_Proto_YacSendVoteSession: ServerSessionUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendVoteSessionBase: ServerSessionUnaryBase<Iroha_Consensus_Yac_Proto_Vote, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendVoteSession {}

internal protocol Iroha_Consensus_Yac_Proto_YacSendCommitSession: ServerSessionUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendCommitSessionBase: ServerSessionUnaryBase<Iroha_Consensus_Yac_Proto_Commit, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendCommitSession {}

internal protocol Iroha_Consensus_Yac_Proto_YacSendRejectSession: ServerSessionUnary {}

fileprivate final class Iroha_Consensus_Yac_Proto_YacSendRejectSessionBase: ServerSessionUnaryBase<Iroha_Consensus_Yac_Proto_Reject, SwiftProtobuf.Google_Protobuf_Empty>, Iroha_Consensus_Yac_Proto_YacSendRejectSession {}


/// Main server for generated service
internal final class Iroha_Consensus_Yac_Proto_YacServer: ServiceServer {
  private let provider: Iroha_Consensus_Yac_Proto_YacProvider

  internal init(address: String, provider: Iroha_Consensus_Yac_Proto_YacProvider) {
    self.provider = provider
    super.init(address: address)
  }

  internal init?(address: String, certificateURL: URL, keyURL: URL, provider: Iroha_Consensus_Yac_Proto_YacProvider) {
    self.provider = provider
    super.init(address: address, certificateURL: certificateURL, keyURL: keyURL)
  }

  internal init?(address: String, certificateString: String, keyString: String, provider: Iroha_Consensus_Yac_Proto_YacProvider) {
    self.provider = provider
    super.init(address: address, certificateString: certificateString, keyString: keyString)
  }

  /// Determines and calls the appropriate request handler, depending on the request's method.
  /// Throws `HandleMethodError.unknownMethod` for methods not handled by this service.
  internal override func handleMethod(_ method: String, handler: Handler) throws -> ServerStatus? {
    let provider = self.provider
    switch method {
    case "/iroha.consensus.yac.proto.Yac/SendVote":
      return try Iroha_Consensus_Yac_Proto_YacSendVoteSessionBase(
        handler: handler,
        providerBlock: { try provider.sendVote(request: $0, session: $1 as! Iroha_Consensus_Yac_Proto_YacSendVoteSessionBase) })
          .run()
    case "/iroha.consensus.yac.proto.Yac/SendCommit":
      return try Iroha_Consensus_Yac_Proto_YacSendCommitSessionBase(
        handler: handler,
        providerBlock: { try provider.sendCommit(request: $0, session: $1 as! Iroha_Consensus_Yac_Proto_YacSendCommitSessionBase) })
          .run()
    case "/iroha.consensus.yac.proto.Yac/SendReject":
      return try Iroha_Consensus_Yac_Proto_YacSendRejectSessionBase(
        handler: handler,
        providerBlock: { try provider.sendReject(request: $0, session: $1 as! Iroha_Consensus_Yac_Proto_YacSendRejectSessionBase) })
          .run()
    default:
      throw HandleMethodError.unknownMethod
    }
  }
}

