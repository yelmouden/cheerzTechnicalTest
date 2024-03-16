//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 14/03/2024.
//

import Foundation
import Dependencies

protocol Requester {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: Requester {}

final class AnyRequester {
    let requester: Requester

    init(requester: Requester) {
        self.requester = requester
    }

    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return try await requester.data(for: request, delegate: delegate)
    }
}

extension DependencyValues {
  var requester: AnyRequester {
    get { self[AnyRequester.self] }
    set { self[AnyRequester.self] = newValue }
  }
}

extension AnyRequester: DependencyKey {
    static var liveValue: AnyRequester {
        AnyRequester(requester: URLSession.shared)
    }
}
