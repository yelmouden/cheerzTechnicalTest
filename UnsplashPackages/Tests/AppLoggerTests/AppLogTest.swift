//
//  AppLogTest.swift
//
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import Foundation
import Nimble
import XCTest

@testable import AppLogger

final class AppLogTest: XCTestCase {

    func testAppLog_shouldInvokeLogginInfo_whenCallInfo() {
        let mockAppLogger = MockAppLoggerType()
        let appLog = AppLogger(loggerType: mockAppLogger)

        appLog.info(message: "this is an info text")
        expect(mockAppLogger.textInfo) == "🔵 this is an info text"
    }

    func testAppLog_shouldInvokeWarningInfo_whenCallWarning() {
        let mockAppLogger = MockAppLoggerType()
        let appLog = AppLogger(loggerType: mockAppLogger)

        appLog.warning(message: "this is an warning text")
        expect(mockAppLogger.textWarning) == "🟠 this is an warning text"
    }

    func testAppLog_shouldInvokeErrorInfo_whenCallError() {
        let mockAppLogger = MockAppLoggerType()
        let appLog = AppLogger(loggerType: mockAppLogger)

        appLog.error(message: "this is an error text")
        expect(mockAppLogger.textError) == "🔴 this is an error text"
    }
}

