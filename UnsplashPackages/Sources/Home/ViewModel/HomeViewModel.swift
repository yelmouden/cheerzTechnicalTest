//
//  HomeViewModel.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Dependencies
import Foundation
import Observation
import SharedModels
import Utils

@Observable
final public class HomeViewModel {
    // MARK: Dependencies

    @ObservationIgnored
    @Dependency(\.homeRepository) var homeRepository

    // MARK: Public Properties

    var state: LoadingState<[Photo]> = .idle

    // MARK: Init

    public init() {}

    // MARK: Public Methods

    // Retrieve latest Photos

    @MainActor
    func retrieve() async {
        do {
            if state == .idle || state == .error {
                state = .loading
            }

            state = .loaded(try await homeRepository.getListPhotos())
        } catch {
            state = .error
        }
    }
}
