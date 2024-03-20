//
//  SwiftUIView.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import SharedModels
import SwiftUI

final class HighResolutionPhotoViewModel {
    // MARK: Private Properties

    private let photo: Photo

    // MARK: Public Properties

    var urlPhoto: String { photo.urlsPhotoType.raw }

    init(photo: Photo) {
        self.photo = photo
    }
}
