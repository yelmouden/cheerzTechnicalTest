//
//  Photo.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

public struct Photo: Decodable, Identifiable, Equatable, Hashable {
    public init(id: String) {
        self.id = id
    }

    public let id: String
}
