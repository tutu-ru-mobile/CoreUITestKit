import Foundation
import XCTest

class TestBase: XCTestCase {
    
 enum Condition: String {
         case appear = "exists == true"
         case disappear = "exists == false"
     }

     func waitFor(_ element: XCUIElement, to condition: Condition) -> Bool {
         let predicate = NSPredicate(format: condition.rawValue)
         let expectationConstant = expectation(for: predicate, evaluatedWith: element, handler: nil)

         let result = XCTWaiter().wait(for: [expectationConstant], timeout: 5)
         return result == .completed
     }
    
    // App
    let app = XCUIApplication()
    
    // Рабочий стол iOS
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app.launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
}



