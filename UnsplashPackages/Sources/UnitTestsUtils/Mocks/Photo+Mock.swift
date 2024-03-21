//
//  File.swift
//
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Foundation
import SharedModels

public extension Photo {
    static func mock(
        id: String = "",
        description: String? = nil,
        altDescription: String? = nil,
        likes: Int = 0,
        urlPhotoRaw: String = "",
        urlPhotoFull: String = "",
        urlPhotoRegular: String = "",
        urlPhotoSmall: String = "",
        urlPhotoThumb: String = "",
        username: String = "",
        urlPhotoProfileSmall: String = "",
        urlPhotoProfileMedium: String = "",
        urlPhotoProfileLarge: String = ""
    ) -> Photo {
        .init(
            id: id,
            description: description,
            altDescription: altDescription,
            likes: likes,
            urlsPhotoType: .init(
                raw: urlPhotoRaw,
                full: urlPhotoFull,
                regular: urlPhotoRegular,
                small: urlPhotoSmall,
                thumb: urlPhotoThumb
            ),
            user: .init(
                username: username,
                urlsProfilePhotoType: .init(
                    small: urlPhotoProfileSmall,
                    medium: urlPhotoProfileMedium,
                    large: urlPhotoProfileLarge
                )
            )
        )
    }
}
