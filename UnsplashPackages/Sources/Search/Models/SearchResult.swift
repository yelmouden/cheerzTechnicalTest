//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import Foundation
import SharedModels

struct SearchResult: Decodable {
    let totalPages: Int
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case totalPages
        case photos = "results"
    }
}
