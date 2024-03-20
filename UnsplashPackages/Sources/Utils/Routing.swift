//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import SwiftUI
import Observation

public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable
    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

@Observable
final public class Routing {
    public var presentedSheet: AnyIdentifiable?
    public var path: NavigationPath

    public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }

    public func push(destination: any Hashable) {
        path.append(destination)
    }

    public func presentSheet(destination: any Identifiable) {
          presentedSheet = AnyIdentifiable(destination: destination)
      }
}
