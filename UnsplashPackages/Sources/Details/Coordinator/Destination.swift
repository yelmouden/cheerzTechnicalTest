//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Foundation
import SharedModels

enum Destination: Identifiable, Hashable {
    var id: Int {
        switch self {
        case .highResolution: return 1
        }
    }

    case highResolution
}
