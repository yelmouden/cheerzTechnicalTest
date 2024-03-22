//
//  AppLogger.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation

public class AppLogger {
    private let loggerType: AppLoggerType

    public init(loggerType: AppLoggerType) {
        self.loggerType = loggerType
    }

    public func info(message: String) {
        loggerType.info(message: "🔵 \(message)")
    }

    public func warning(message: String) {
        loggerType.warning(message: "🟠 \(message)")
    }

    public func error(message: String) {
        loggerType.error(message: "🔴 \(message)")
    }
}
