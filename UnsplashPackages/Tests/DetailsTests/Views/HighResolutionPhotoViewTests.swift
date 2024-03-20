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

final class HighResolutionPhotoViewTests: XCTestCase {
    class override func setUp() {
        isRecording = true
        configureSnapshotTest()
    }

    func testHighResolutionVew_shouldDisplayImage() {

        guard let photoPath = XCTestUtilsBundle.path(forResource: "photo", ofType: "jpeg")
        else {
            XCTFail("Image not found")
            return
        }

        let photoKey = "photo"
        guard let imagePhoto = UIImage(contentsOfFile: photoPath) else {
            XCTFail("Image not initialized")
            return
        }

        let viewModel = HighResolutionPhotoViewModel(
            photo: .mock(
                description: "this a description",
                likes: 10,
                urlPhotoFull: photoKey,
                username: "username 1"
            )
        )

        let view = NavigationStack {
            HighResolutionPhotoView(viewModel: viewModel)
        }
        .environment(Routing())
        .environment(\.imageLoader ,ImageLoaderMock(images: [photoKey: imagePhoto]))

        let vc = convertToViewControllerForSnapshotTesting(view: view)

        assertSnapshot(of: vc, as: .image(on: .iPhone13))
    }
}
