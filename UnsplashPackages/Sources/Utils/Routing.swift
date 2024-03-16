//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable
final public class Routing {
    private var path: NavigationPath

    public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }

    public func push(destination: some Hashable) {
        path.append(destination)
    }
}
