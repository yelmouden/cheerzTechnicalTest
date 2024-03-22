//
//  HomeService.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import Networking

enum HomeService {
    case photos
}

extension HomeService: ServiceType {
    var path: String { "/photos" }

    var method: RequestMethod { .get }

    var quertyItems: [URLQueryItem]? {
        [.init(name: "per_page", value: "30")]
    }
}
