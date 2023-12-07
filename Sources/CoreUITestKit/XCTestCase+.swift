//
// Copyright © 2023 LLC "Globus Media". All rights reserved.
//

import XCTest

extension XCTestCase {
    /// Используем для получания скриншота с места падения теста
    public func takeScreenshot(name screenshotName: String? = nil) {
        let screenshot = XCUIScreen.main.screenshot()
        let attach = XCTAttachment(screenshot: screenshot, quality: .medium)
        attach.name = screenshotName ?? name + "_" + UUID().uuidString
        attach.lifetime = .keepAlways
        add(attach)
    }
}
