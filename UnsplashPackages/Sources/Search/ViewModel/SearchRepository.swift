//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import Foundation
import Dependencies
import Networking
import SharedModels

struct SearchRepository {
    var search: (String, Int) async throws -> SearchResult
}


// Add Search Repository as Dependency

extension DependencyValues {
  var seachRepository: SearchRepository {
    get { self[SearchRepository.self] }
    set { self[SearchRepository.self] = newValue }
  }
}

extension SearchRepository: DependencyKey {
    static var liveValue: SearchRepository = SearchRepository { text, page in
        let networking = Networking()
        return try await networking.request(service: SearchService.search(text: text, page: page))
    }
}
