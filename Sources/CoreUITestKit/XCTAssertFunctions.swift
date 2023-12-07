//
// Copyright © 2023 LLC "Globus Media". All rights reserved.
//

import XCTest

public func dsl_XCTAssertTrue(
    XCUIElement: XCUIElement,
    action: XCUIElement.Action,
    errorMessage: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTContext.runActivity(named: "Проверка элемента '\(XCUIElement)' на \(action.self)" ) { _ in
        XCTAssertTrue(
            XCUIElement.checkAction(action),
            errorMessage(),
            file: file,
            line: line
        )
    }
}

public func dsl_XCTAssertFalse(
    XCUIElement: XCUIElement,
    action: XCUIElement.Action,
    errorMessage: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTContext.runActivity(named: "Проверка элемента '\(XCUIElement)' на не \(action.self)" ) { _ in
        XCTAssertFalse(
            XCUIElement.checkAction(action),
            errorMessage(),
            file: file,
            line: line
        )
    }
}

public func dsl_XCTAssertEqual<T: Equatable>(
    expression1: T,
    expression2: T,
    errorMessage: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTContext.runActivity(named: "Проверить значение \(expression1) на равенство с \(expression2)") { _ in
        XCTAssertEqual(
            expression1,
            expression2,
            errorMessage(),
            file: file,
            line: line
        )
    }
}

public func dsl_XCTAssertNotEqual<T: Equatable>(
    expression1: T,
    expression2: T,
    errorMessage: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line
) {
    XCTContext.runActivity(named: "Проверить значение \(expression1) на неравенство с  \(expression2)") { _ in
        XCTAssertNotEqual(
            expression1,
            expression2,
            errorMessage(),
            file: file,
            line: line
        )
    }
}
