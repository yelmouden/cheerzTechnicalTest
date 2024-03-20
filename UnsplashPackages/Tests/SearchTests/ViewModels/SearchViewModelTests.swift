//
//  SearchViewModel.swift
//
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import ConcurrencyExtras
import Dependencies
import SharedModels
import Nimble
import XCTest

@testable import Search
final class SearchViewModelTests: XCTestCase {

    func testSearchViewModel_shouldReturnIdleState_asDefault() {
        let viewModel = SearchViewModel()
        expect(viewModel.state) == .idle
    }

    func testSearchViewModel_shouldReturnLoadingState_whenStartRequesting() {
        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _, _ in
                try await Task.sleep(for: .seconds(1))
                return .init(totalPages: 1, photos: [])
            })
        } operation: {
            SearchViewModel()
        }

        Task {
            await searchViewModel.search(text: "Paris")
        }

        expect(searchViewModel.state).toEventually(equal(.loading))
    }

    func testSearchViewModel_shouldReturnPhotosState_whenRequestFinished() async {
        let expectedPhotos: [Photo] = [
            .mock(id: "1", username: "username 1")
        ]


        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                return .init(
                    totalPages: 1,
                    photos: expectedPhotos
                )
            })
        } operation: {
            SearchViewModel()
        }

        await searchViewModel.search(text: "Paris")

        expect(searchViewModel.state) == .loaded(expectedPhotos)
    }

    func testSearchViewModel_shouldReturnAppendedPhotos_whenLoadMorePhotos() async {
        var poolPhotos: [Photo] = [
            .mock(id: "1", username: "username 1"),
            .mock(id: "2", username: "username 2")
        ]

        let expectedPhotos = poolPhotos

        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                let photos = [poolPhotos.removeFirst()]
                return .init(
                    totalPages: 2,
                    photos: photos
                )
            })
        } operation: {
            SearchViewModel()
        }

        await searchViewModel.search(text: "Paris")

        await searchViewModel.search(text: "Paris", shouldLoadNextPage: true)

        expect(searchViewModel.state) == .loaded(expectedPhotos)
    }

    func testSearchViewModel_shouldNotMakeSearchRequest_whenHasNoMorePageToLoad() async {
        var nbRequest = 0

        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                nbRequest += 1
                return .init(
                    totalPages: 2,
                    photos: []
                )
            })
        } operation: {
            SearchViewModel()
        }

        await searchViewModel.search(text: "Paris")

        await searchViewModel.search(text: "Paris", shouldLoadNextPage: true)

        expect(nbRequest) == 2
    }

    func testSearchViewModel_shouldReturnError_whenRequestFailed() async {
        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                throw URLError(URLError.badServerResponse)
            })
        } operation: {
            SearchViewModel()
        }

        await searchViewModel.search(text: "Paris")

        expect(searchViewModel.state) == .error
    }

    func testSearchViewModel_shouldNotSetStateAsError_whenRequestForMorePhotosFailed() async {

        let photos: [Photo] = [
            .mock(id: "1", username: "username 1")
        ]

        var results = [Result<SearchResult, Error>]()

        results.append(.success(.init(totalPages: 1, photos: photos)))
        results.append(.failure(URLError(URLError.badServerResponse)))

        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                switch results.removeFirst() {
                case .success(let result):
                    return result
                case .failure(let error):
                    throw error
                }


            })
        } operation: {
            SearchViewModel()
        }

        await searchViewModel.search(text: "Paris")
        await searchViewModel.search(text: "Paris", shouldLoadNextPage: true)

        expect(searchViewModel.state) == .loaded(photos)
    }
}
