//
//  Photo.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import Utils

public struct Photo: Decodable, Identifiable, Equatable, Hashable {
    public let id: String
    public let likes: Int
    public let urlsPhotoType: URLPhotoTypes
    public let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case likes
        case urlsPhotoType = "urls"
        case user
    }

    public init(
        id: String,
        likes: Int,
        urlsPhotoType: URLPhotoTypes,
        user: User
    ) {
        self.id = id
        self.likes = likes
        self.urlsPhotoType = urlsPhotoType
        self.user = user
    }
}

// MARK: - Photo

public extension Photo {
    struct URLPhotoTypes: Decodable, Equatable, Hashable {
        public let raw: String
        public let full: String
        public let regular: String
        public let small: String
        public let thumb: String

        public init(
            raw: String,
            full: String,
            regular: String,
            small: String,
            thumb: String
        ) {
            self.raw = raw
            self.full = full
            self.regular = regular
            self.small = small
            self.thumb = thumb
        }
    }
}

// MARK: - User

public extension Photo {
    struct User: Decodable, Equatable, Hashable {
        public let username: String
        public let urlsProfilePhotoType: URLProfilePhotoTypes

        public init(username: String, urlsProfilePhotoType: URLProfilePhotoTypes) {
            self.username = username
            self.urlsProfilePhotoType = urlsProfilePhotoType
        }

        enum CodingKeys: String, CodingKey {
            case username
            case urlsProfilePhotoType = "profileImage"
        }
    }
}

public extension Photo.User {
    struct URLProfilePhotoTypes: Decodable, Equatable, Hashable {
        public let small: String
        public let medium: String
        public let large: String

        public init(small: String, medium: String, large: String) {
            self.small = small
            self.medium = medium
            self.large = large
        }
    }
}
