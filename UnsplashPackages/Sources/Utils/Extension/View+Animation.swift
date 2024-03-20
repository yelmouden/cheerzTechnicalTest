//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 19/03/2024.
//

import Foundation
import SwiftUI

/// Method for animation
/// This method disables animation when running tests
extension View {
    public func animate<V>(_ animation: Animation?, value: V) -> some View where V: Equatable {
        if NSClassFromString("XCTest") != nil {
            return self.animation(nil, value: value)
        } else {
            return self.animation(animation, value: value)
        }
    }
}