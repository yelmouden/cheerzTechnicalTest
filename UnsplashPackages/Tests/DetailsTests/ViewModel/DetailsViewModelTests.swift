//
//  DetailsViewModelTests.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Nimble
import SharedModels
import XCTest
import UnitTestsUtils

@testable import Details

final class DetailsViewModelTests: XCTestCase {

    func testDetailsViewModel_shouldReturnTheCorrectValueForProperties() {
        let photo = Photo.mock(
            description: "this is a description",
            likes: 10,
            urlPhotoRegular: "https://images.unsplash.com/photo-1682685797140-c17807f8f217",
            urlPhotoProfileLarge: "https://images.unsplash.com/profile-1679489218992-ebe823c797dfimage"
        )

        let detailsViewModel = DetailsViewModel(photo: photo)

        expect(detailsViewModel.urlPhoto) == "https://images.unsplash.com/photo-1682685797140-c17807f8f217"
        expect(detailsViewModel.nbLikes) == 10
        expect(detailsViewModel.urlPhoto) == "https://images.unsplash.com/photo-1682685797140-c17807f8f217"
        expect(detailsViewModel.urlProfilePhoto) == "https://images.unsplash.com/profile-1679489218992-ebe823c797dfimage"
    }
}
