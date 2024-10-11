//
//  LoggerType.swift
//  
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import OSLog

public protocol AppLoggerType {
    func info(message: String)
    func warning(message: String)
    func error(message: String)
}

extension Logger: AppLoggerType {
    public func info(message: String) {
        info("\(message, privacy: .public)")
    }

    public func warning(message: String) {
        warning("\(message, privacy: .public)")
    }

    public func error(message: String) {
        error("\(message, privacy: .public)")
    }
}
