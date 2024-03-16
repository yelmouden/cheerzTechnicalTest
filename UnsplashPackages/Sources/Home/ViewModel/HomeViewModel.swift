//
//  HomeViewModel.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import Dependencies
import Observation
import SharedModels
import Utils

@Observable
final class HomeViewModel {
    
    // MARK: Dependencies

    @ObservationIgnored
    @Dependency(\.homeRepository) var homeRepository

    // MARK: Public Properties

    var state: State<[Photo]> = .loading

    // MARK: Init

    init() {
        Task {
            //await retrieve()
        }
    }

    // MARK: Public Methods

    // Retrieve latest Photos
    @MainActor
    func retrieve() async {
        do {
            state = .loaded(try await homeRepository.getListPhotos())
        } catch {
            state = .error
        }

        print("state", state)
    }
}
