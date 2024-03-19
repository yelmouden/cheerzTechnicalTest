//
//  SearchViewTests.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import AppConfiguration
import Dependencies
import DesignSystem
import SnapshotTesting
import SwiftUI
import Utils
import XCTestUtils
import XCTest

@testable import Search

final class SearchViewTests: XCTestCase {
    class override func setUp() {
        isRecording = false
        configureSnapshotTest()
    }

    func testSearch_shouldBeIdle_whenAppear() {
        let view = NavigationStack {
            SearchView(viewModel: SearchViewModel())
        }
        .environment(Routing())

        let vc = convertToViewControllerForSnapshotTesting(view: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }

    func testSearch_shouldDisplayGrid_whenRequestSuccedeed() {
        
        guard let photoPath = XCTestUtilsBundle.path(forResource: "photo", ofType: "jpeg"),
              let profilePhotoPath = XCTestUtilsBundle.path(forResource: "profilePhoto", ofType: "jpeg")
        else {
            XCTFail("Image not found")
            return
        }

        let photoKey = "photo"
        guard let imagePhoto = UIImage(contentsOfFile: photoPath) else {
            XCTFail("Image not initialized")
            return
        }

        let profilePhotoKey = "profile"
        guard let imageProfilePhoto = UIImage(contentsOfFile: profilePhotoPath) else {
            XCTFail("Image not initialized")
            return
        }

        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                .init(
                    totalPages: 1,
                    photos: [
                        .init(
                            id: "1",
                            likes: 20,
                            urlsPhotoType: .init(
                                raw: "",
                                full: "",
                                regular: "",
                                small: photoKey,
                                thumb: ""
                            ),
                            user: .init(
                                username: "username 1",
                                urlsProfilePhotoType: .init(
                                    small: profilePhotoKey,
                                    medium: "",
                                    large: ""
                                )
                            )
                        ),
                        .init(
                            id: "2",
                            likes: 20,
                            urlsPhotoType: .init(
                                raw: "",
                                full: "",
                                regular: "",
                                small: photoKey,
                                thumb: ""
                            ),
                            user: .init(
                                username: "username 2",
                                urlsProfilePhotoType: .init(
                                    small: profilePhotoKey,
                                    medium: "",
                                    large: ""
                                )
                            )
                        )
                    ]
                )
            })
        } operation: {
            SearchViewModel()
        }

        let view = NavigationStack {
            SearchView(viewModel: searchViewModel)
        }
        .environment(Routing())
        .environment(\.imageLoader ,ImageLoaderMock(images: ["photo": imagePhoto, "profile": imageProfilePhoto]))

        Task {
            await searchViewModel.search(text: "paris")
        }

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }

    func testSearch_shouldDisplayEmptyText_whenRequestReturnEmptyData() {
        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                    .init(totalPages: 1, photos: [])
            })
        } operation: {
            SearchViewModel()
        }

        Task {
            await searchViewModel.search(text: "paris")
        }

        let view = NavigationStack {
            SearchView(viewModel: searchViewModel)
        }
        .environment(Routing())

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }

    func testSearch_shouldDisplayLoading_whenPendingRequest() {
        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                try await Task.sleep(for: .seconds(1))
                return .init(totalPages: 1, photos: [])
            })
        } operation: {
            SearchViewModel()
        }

        let view = NavigationStack {
            SearchView(viewModel: searchViewModel)
        }
        .environment(Routing())

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        Task {
            await searchViewModel.search(text: "paris")
        }

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }

    func testSearch_shouldDisplayError_whenRequestFailed() {
        let searchViewModel = withDependencies {
            $0.seachRepository = .init(search: { _,_ in
                throw URLError(URLError.badServerResponse)
            })
        } operation: {
            SearchViewModel()
        }

        Task {
            await searchViewModel.search(text: "paris")
        }

        let view = NavigationStack {
            SearchView(viewModel: searchViewModel)
        }
        .environment(Routing())

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }
}
