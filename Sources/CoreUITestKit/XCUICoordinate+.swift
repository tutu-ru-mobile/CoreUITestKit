
import XCTest
import Foundation

extension XCUICoordinate {
    public func dsl_press(forDuration: TimeInterval, thenDragTo: XCUICoordinate) {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Пресс тап по элементу \(String(describing: resourceName))") { _ in
            self.press(forDuration: forDuration, thenDragTo: thenDragTo)
        }
    }
}
