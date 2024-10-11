//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import Foundation
import Networking

enum SearchService: ServiceType {
    case search(text: String, page: Int)

    var path: String { "/search/photos" }

    var method: RequestMethod { .get }

    var quertyItems: [URLQueryItem]? {
        switch self {
        case let .search(text, page):
            [
                .init(name: "query", value: text),
                .init(name: "page", value: "\(page)")
            ]
        }
    }
}
