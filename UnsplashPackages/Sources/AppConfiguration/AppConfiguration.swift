//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

public enum AppConfiguration {
    public static var apiEndPoint: String { return Info().API_ENDPOINT }
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
