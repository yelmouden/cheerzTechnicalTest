//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 15/03/2024.
//

import Foundation

@testable import AppLogger

final class MockAppLoggerType: AppLoggerType {
    var textInfo: String = ""
    var textWarning: String = ""
    var textError: String = ""

    func info(message: String) {
        textInfo = message
    }
    
    func warning(message: String) {
        textWarning = message
    }
    
    func error(message: String) {
        textError = message
    }
}
