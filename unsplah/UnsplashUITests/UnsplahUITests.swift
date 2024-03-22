//
//  UnsplahUITests.swift
//  UnsplahUITests
//
//  Created by Yassin El Mouden on 16/03/2024.
//

import XCTest

final class UnsplashUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
      self.app = XCUIApplication()
      self.app.launchEnvironment["UI_TEST_NAME"] = String(
        self.name.split(separator: " ").last?.dropLast() ?? ""
      )
      self.app.launch()
    }

    func testNavigationHomeScreenToHighResolutionScreen() {
        app.scrollViews.children(matching: .other).element(boundBy: 0).tap()
        app.descendants(matching: .any)["highResolution"].tap()
        XCTAssertEqual(self.app.staticTexts["High resolution"].exists, true)
    }

    func testNavigationSearchScreenToHighResolutionScreen() {
        app.tabBars.buttons.element(boundBy: 1).tap()
        let searchField = app.navigationBars["Search"].searchFields["Search"]
        searchField.tap()
        searchField.typeText("Ma")
        app.scrollViews.children(matching: .other).element(boundBy: 0).tap()
        app.descendants(matching: .any)["highResolution"].tap()
        XCTAssertEqual(self.app.staticTexts["High resolution"].exists, true)
    }

}
