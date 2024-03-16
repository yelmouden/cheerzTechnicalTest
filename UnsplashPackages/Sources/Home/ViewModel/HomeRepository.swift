//
//  HomeRepository.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import Dependencies
import Networking
import SharedModels

struct HomeRepository {
    let getListPhotos: () async throws -> [Photo]
}

// Add Home Repository as Dependency

extension DependencyValues {
  var homeRepository: HomeRepository {
    get { self[HomeRepository.self] }
    set { self[HomeRepository.self] = newValue }
  }
}

extension HomeRepository: DependencyKey {
    static var liveValue: HomeRepository = HomeRepository {
        let networking = Networking()
        return try await networking.request(service: HomeService.photos)
    }
}
