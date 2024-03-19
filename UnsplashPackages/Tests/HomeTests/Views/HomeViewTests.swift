//
//  HomeViewTests.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import AppConfiguration
import Dependencies
import DesignSystem
import SnapshotTesting
import SwiftUI
import Utils
import XCTest
import XCTestUtils

@testable import Home

final class HomeViewTests: XCTestCase {

    class override func setUp() {
        isRecording = false
        configureSnapshotTest()
    }

    func testHomeView_shouldDisplayLoadingView_whenInit() {
        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                []
            })
        } operation: {
            HomeViewModel()
        }

        let view = NavigationStack {
            HomeView(viewModel: homeViewModel)
        }
        .environment(Routing())
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    func testHomeView_shouldDisplayGrid_whenRequestSuccedeed() {
        guard let photoPath = XCTestUtilsBundle.path(forResource: "photo", ofType: "jpeg"),
              let profilePhotoPath = XCTestUtilsBundle.path(forResource: "profilePhoto", ofType: "jpeg")
        else {
            XCTFail("Image not found")
            return
        }

        // Image Use for photo
        let photoKey = "photo"
        guard let imagePhoto = UIImage(contentsOfFile: photoPath) else {
            XCTFail("Image not initialized")
            return
        }

        // Image Use for profile photo
        let profilePhotoKey = "profile"
        guard let imageProfilePhoto = UIImage(contentsOfFile: profilePhotoPath) else {
            XCTFail("Image not initialized")
            return
        }

        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                [
                    .init(
                        id: "1",
                        likes: 100,
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
                        likes: 100,
                        urlsPhotoType: .init(
                            raw: "",
                            full: "",
                            regular: "",
                            small: photoKey,
                            thumb: ""
                        ),
                        user: .init(
                            username: "username 2 ",
                            urlsProfilePhotoType: .init(
                                small: profilePhotoKey,
                                medium: "",
                                large: ""
                            )
                        )
                    ),
                    .init(
                        id: "3",
                        likes: 100,
                        urlsPhotoType: .init(
                            raw: "",
                            full: "",
                            regular: "",
                            small: photoKey,
                            thumb: ""
                        ),
                        user: .init(
                            username: "username 3",
                            urlsProfilePhotoType: .init(
                                small: profilePhotoKey,
                                medium: "",
                                large: ""
                            )
                        )
                    )
                ]
            })
        } operation: {
            HomeViewModel()
        }

        let view = NavigationStack {
            HomeView(viewModel: homeViewModel)
        }
        .environment(Routing())
        .environment(\.imageLoader ,ImageLoaderMock(images: ["photo": imagePhoto, "profile": imageProfilePhoto]))


       let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }

    func testHomeView_shouldDisplayErrorView_whenRequestFailed() {
        let homeViewModel = withDependencies {
            $0.homeRepository = .init(getListPhotos: {
                throw URLError(URLError.badServerResponse)
            })
        } operation: {
            HomeViewModel()
        }

        let view = NavigationStack {
            HomeView(viewModel: homeViewModel)
        }
        .environment(Routing())

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }
}

