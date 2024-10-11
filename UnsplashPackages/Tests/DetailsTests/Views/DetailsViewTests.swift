//
//  DetailsViewTests.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import SnapshotTesting
import SwiftUI
import Utils
import UnitTestsUtils
import XCTest

@testable import Details

final class DetailsViewTests: XCTestCase {
    class override func setUp() {
        isRecording = false
        configureSnapshotTest()
    }

    func testDetailsVew_shouldDisplayImage() {

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

        let viewModel = DetailsViewModel(
            photo: .mock(
                description: "this a description",
                likes: 10,
                urlPhotoRegular: photoKey,
                username: "username 1",
                urlPhotoProfileLarge: profilePhotoKey
            )
        )

        let view = NavigationStack {
            DetailsView(viewModel: viewModel)
        }
        .environment(Routing())
        .environment(\.imageLoader ,ImageLoaderMock(images: ["photo": imagePhoto, "profile": imageProfilePhoto]))

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .wait(for: 1, on: .image(on: .iPhone13)))
    }
}
