//
//  MockService.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

@testable import Networking

enum MockService: ServiceType {
    case mock
    
    var path: String { "" }
    var method: RequestMethod { .get }
}
