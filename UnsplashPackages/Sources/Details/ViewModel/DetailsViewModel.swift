//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Foundation
import SharedModels

final class DetailsViewModel {
    // MARK: Private Properties

    private let photo: Photo

    // MARK: Public Properties

    var urlPhoto: String { photo.urlsPhotoType.regular }
    var nbLikes: Int { photo.likes }
    var description: String { photo.descriptionText }
    var urlProfilePhoto: String { photo.user.urlsProfilePhotoType.large }
    var username: String { photo.user.username }


    init(photo: Photo) {
        self.photo = photo
    }
}
