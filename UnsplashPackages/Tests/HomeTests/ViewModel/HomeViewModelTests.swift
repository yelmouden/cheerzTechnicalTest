//
//  HomeViewModelTests.swift
//
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import Dependencies
import SharedModels
import Nimble
import XCTest

@testable import Home

final class HomeViewModelTests: XCTestCase {

    func testHomeViewModel_shouldHaveStateLoading_whenInit() {
        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                try await Task.sleep(for: .seconds(1))
                return []
            })
        } operation: {
            HomeViewModel()
        }

        Task {
            await homeViewModel.retrieve()
        }

        expect(homeViewModel.state).toEventually(equal(.loading))
    }

    func testHomeViewModel_shouldHaveStateLoaded_whenRequestSucceeded() async {
        let expectedData: [Photo] = [.mock(id: "1", username: "user")]

        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                expectedData
            })
        } operation: {
            HomeViewModel()
        }

        await homeViewModel.retrieve()
        expect(homeViewModel.state) == .loaded(expectedData)
    }

    func testHomeViewModel_shouldHaveStateError_whenRequestFailed() async {
        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                throw URLError(URLError.Code.badServerResponse)
            })
        } operation: {
            HomeViewModel()
        }

        await homeViewModel.retrieve()
        expect(homeViewModel.state) == .error
    }
}
