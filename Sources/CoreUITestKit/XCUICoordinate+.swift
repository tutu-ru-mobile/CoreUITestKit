
import XCTest
import Foundation

extension XCUICoordinate {
    public func dsl_press(forDuration duration: TimeInterval, thenDragTo dragTo: XCUICoordinate) {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Пресс тап по элементу \(String(describing: resourceName))") { _ in
            self.press(forDuration: duration, thenDragTo: dragTo)
        }
    }
}
