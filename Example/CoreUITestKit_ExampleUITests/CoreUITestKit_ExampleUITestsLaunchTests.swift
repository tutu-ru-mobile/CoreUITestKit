//
//  CoreUITestKit_ExampleUITestsLaunchTests.swift
//  CoreUITestKit_ExampleUITests
//
//  Created by Verigin Sergey on 28.07.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest

final class CoreUITestKit_ExampleUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
