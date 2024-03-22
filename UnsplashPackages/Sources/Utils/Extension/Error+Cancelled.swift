//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 20/03/2024.
//

import Foundation

public extension Error {
    var isCancelledError: Bool {
        (self is CancellationError) || (self as? URLError)?.code == .cancelled
    }
}
