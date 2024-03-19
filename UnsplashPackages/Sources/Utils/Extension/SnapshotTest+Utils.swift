//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 18/03/2024.
//

import Foundation
import SwiftUI
import UIKit

public func convertToViewControllerForSnapshotTesting(view: some View) -> UIViewController {
    let viewController = UIHostingController(rootView: view.transaction { $0.animation = nil })

    let window = UIWindow(frame: .init(origin: .zero, size: .init(width: 1, height: 1)))
    window.rootViewController = viewController
    window.makeKeyAndVisible()

    return viewController
}
