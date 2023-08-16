
import Foundation
import XCTest

extension XCTestCase {
    func dsl_XCTAssertTrue(XCUIElement: XCUIElement, action: XCUIElement.Action, errorMassage: @autoclosure () -> String) {
        XCTContext.runActivity(named: "Проверка элемента '\(XCUIElement)' на \(action.self)" ) { _ in
            XCTAssertTrue(
                XCUIElement.checkAction(action),
                errorMassage()
            )
        }
    }

    func dsl_XCTAssertFalse(XCUIElement: XCUIElement, action: XCUIElement.Action, errorMassage: @autoclosure () -> String) {
        XCTContext.runActivity(named: "Проверка элемента '\(XCUIElement)' на не \(action.self)" ) { _ in
            XCTAssertFalse(
                XCUIElement.checkAction(action),
                errorMassage()
            )
        }
    }

    func dsl_XCTAssertEqual<T: Equatable>(expression1: T, expression2: T) {
        XCTContext.runActivity(named: "Проверить значение \(expression1) на равенство с \(expression2)") { _ in
            XCTAssertEqual(
                expression1,
                expression2
            )
        }
    }
}