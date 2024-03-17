//
//  UnsplahApp.swift
//  Unsplah
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import AppConfiguration
import DesignSystem
import SwiftUI

@main
struct UnsplahApp: App {

    init() {
        AppConfiguration.setupNavigationBar(backgroundColor: DSColors.background.color, titleColor: DSColors.whiteText.color)
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
