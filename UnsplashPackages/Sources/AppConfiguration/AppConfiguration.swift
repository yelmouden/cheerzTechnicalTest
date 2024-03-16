//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import UIKit

public class AppConfiguration {
    public enum API {
        public static var apiEndPoint: String { return Info().API_ENDPOINT }
        public static var apiKey: String { return Info().API_KEY }
    }

    public static func setupNavigationBar(backgroundColor: UIColor, titleColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backgroundColor

        let uiTitleColor = titleColor
        appearance.largeTitleTextAttributes = [.foregroundColor: uiTitleColor]
        appearance.titleTextAttributes = [.foregroundColor: uiTitleColor]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

}

private extension AppConfiguration {
    @dynamicMemberLookup
    struct Info {
        public subscript<T>(dynamicMember member: String) -> T {
            guard let value = Bundle.main.infoDictionary?[member] as? T else {
                fatalError("Invalid or missing Info.plist key: \(member)")
            }
            return value
        }
    }
}
