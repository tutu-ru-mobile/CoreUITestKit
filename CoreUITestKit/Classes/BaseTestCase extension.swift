
import Foundation
import XCTest


extension BaseTestCase {
    func XCTAssertTrue(_ XCUIElement: XCUIElement, _ errorMassage: @autoclosure () -> String, _ action: XCUIElement.Action) {
        XCTContext.runActivity(named: "Проверка элемента \(XCUIElement) на истину" ) { _ in
            XCTAssertTrue(
                XCUIElement.checkAction(action),
                errorMassage()
            )
        }
    }
    
    func XCTAssertFalse(_ XCUIElement: XCUIElement, _ errorMassage: @autoclosure () -> String, _ action: XCUIElement.Action) {
        XCTContext.runActivity(named: "Проверка элемента \(XCUIElement) на ложь" ) { _ in
            XCTAssertFalse(
                XCUIElement.checkAction(action),
                errorMassage()
            )
        }
    }
    
    func XCTAssertEqual<T: Equatable>(_ expression1: T, _ expression2: T, _ errorMessage: @autoclosure () -> String) {
        XCTContext.runActivity(named: "Проверить значение \(expression1) на равенство с \(expression2)") { _ in
            XCTAssertEqual(
                expression1,
                expression2,
                errorMessage()
            )
        }
    }
}
