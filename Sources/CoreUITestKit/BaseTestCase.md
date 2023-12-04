//
// Copyright © 2023 LLC "Globus Media". All rights reserved.
//

import Foundation
import XCTest

class BaseTestCase: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        app.launchArguments += ["-AppleLanguages", "(ru)"]
        app.launchArguments += ["-AppleLocale", "ru_RU"]
        app.launchEnvironment = ["isUITest": "yes"]
        continueAfterFailure = false
        feature("<Some solution> IOS autotest")
    }
    
    override func tearDown() {
        super.tearDown()
        guard let testRun else { return XCTFail("TestRun error") }
        if testRun.failureCount > 0 {
            step("Скриншот с места падения") {
                takeScreenshot()
            }
        }
        app.terminate()
    }
}
