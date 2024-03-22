//
//  HighResolutionPhotoViewModelTests.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Nimble
import SharedModels
import XCTest
import UnitTestsUtils

@testable import Details

final class HighResolutionPhotoViewModelTests: XCTestCase {

    func testHighResolutionPhotoViewModel_shouldReturnTheCorrectValueForProperties() {
        let photo = Photo.mock(
            urlPhotoFull: "https://images.unsplash.com/photo-1682685797140-c17807f8f217"
        )

        let viewModel = HighResolutionPhotoViewModel(photo: photo)

        expect(viewModel.urlPhoto) == "https://images.unsplash.com/photo-1682685797140-c17807f8f217"
    }
}
