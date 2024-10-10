//
//  MockRequester.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

@testable import Networking

class MockRequester: Requester {
    
    let result: Result<Data, Error>

    init(result: Result<Data, Error>) {
        self.result = result
    }

    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        switch result {
        case .success(let data):
            return (data, .init())
        case .failure(let error):
            throw error
        }
    }
    

}
