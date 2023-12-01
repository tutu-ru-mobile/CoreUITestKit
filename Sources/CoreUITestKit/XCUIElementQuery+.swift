
import Foundation
import XCTest

extension XCUIElementQuery {
    public var dsl_count: Int {
        let resourceName = self.element
        return XCTContext.runActivity(named: "Получить колличество элемента \(String(describing: resourceName))") { _ in
            return self.count
        }
    }
}
