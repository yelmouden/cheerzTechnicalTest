//
//  HomeViewTests.swift
//
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import AppConfiguration
import ConcurrencyExtras
import Dependencies
import DesignSystem
import SnapshotTesting
import SwiftUI
import Utils
import XCTest
import UnitTestsUtils

@testable import Home

@MainActor
final class HomeViewTests: XCTestCase {

    class override func setUp() {
        isRecording = false
        configureSnapshotTest()
    }

    func testHomeView_shouldDisplayLoadingView_whenInit() async{
        await withMainSerialExecutor {
            let homeViewModel = withDependencies {
                $0.homeRepository = .init(getListPhotos: {
                    try await Task.sleep(for: .seconds(1))
                    return []
                })
            } operation: {
                HomeViewModel()
            }

            let view = NavigationStack {
                HomeView(viewModel: homeViewModel)
            }
            .environment(Routing())

            Task {
                await homeViewModel.retrieve()
            }

            await Task.yield()

            let vc = convertToViewControllerForSnapshotTesting(view: view)

            assertSnapshot(of: vc, as: .image(on: .iPhone13))
        }

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
                    .mock(id: "1", urlPhotoSmall: photoKey, username: "username 1", urlPhotoProfileSmall: profilePhotoKey),
                    .mock(id: "2", urlPhotoSmall: photoKey, username: "username 2", urlPhotoProfileSmall: profilePhotoKey),
                    .mock(id: "3", urlPhotoSmall: photoKey, username: "username 3", urlPhotoProfileSmall: profilePhotoKey)
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

        assertSnapshot(of: vc, as: .wait(for: 2, on: .image(on: .iPhone13)))
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

