import Foundation
import XCTest
import UIKit

extension TestBase {
    
    
    func waitForElementToAppear(_ element: XCUIElement) -> Bool{
        let predicate = NSPredicate(format: "exists == true")
        let expectat = expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [expectat], timeout: 20)
        return result == .completed
    }
    
    func waitForElementToAppearLong(_ element: XCUIElement) -> Bool{
        let predicate = NSPredicate(format: "exists == true")
        let expectat = expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [expectat], timeout: 300)
        return result == .completed
    }
    
    func waitForElementToAppearShort(_ element: XCUIElement) -> Bool{
        let predicate = NSPredicate(format: "exists == true")
        let expectat = expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [expectat], timeout: 5)
        return result == .completed
    }
    
    // Тапаем на Allow
    func allowOnSystemAlert() {
        XCTContext.runActivity(named: "Allow on geo request") { _ in
            let allowBtn = springboard.buttons["Allow"]
            if allowBtn.waitForExistence(timeout: 10) {
                allowBtn.tap()
            }
            if allowBtn.waitForExistence(timeout: 0.5) {
                allowBtn.tap()
            }
        }
    }
    
    // Тапаем на Don't Allow
    func dontAllowOnSystemAlert() {
        XCTContext.runActivity(named: "Don’t Allow on geo request") { _ in
            let disallowBtn = springboard.buttons["Don’t Allow"]
            if disallowBtn.waitForExistence(timeout: 10) {
                disallowBtn.tap()
            }
            
            if disallowBtn.waitForExistence(timeout: 0.5) {
                disallowBtn.tap()
            }
        }
    }
    
    // Нажимаем на кнопку
    func tapButton(name: String) {
        XCTContext.runActivity(named: "Tap button \(name)") { _ in
            app.buttons[name].tap()
        }
    }
    
    //Нажатие на кнопки нижнего бара
    func tabBarsQuery(name: String) {
        let tabBarsQuery = XCUIApplication().tabBars
        XCTContext.runActivity(named: "Tap button \(name)") { _ in
            tabBarsQuery.buttons[name].tap()
        }
    }
    
    func tapTableText(name: String) {
        let tablesQuery = app.tables
        XCTContext.runActivity(named: "Assert text \(name)") { _ in
            tablesQuery.staticTexts[name].tap()
        }
    }
    
    func tapTableElementCell(name: String) {
        let tablesQuery = app.tables.element
        XCTContext.runActivity(named: "Assert text \(name)") { _ in
            tablesQuery.cells[name].tap()
        }
    }
    
    func switchLang(name: String) {
        let russianKey = app.keys[name]
        if waitFor(russianKey, to: .appear) {
                 //NOTHING
        } else {
            app.buttons["Next keyboard"].tap()
            switchLang(name: name)
        }
    }
    
    func tapWebViewText(name: String) {
           let webViewsQuery = app.webViews.webViews
           XCTContext.runActivity(named: "Assert text \(name)") { _ in
               webViewsQuery.staticTexts[name].tap()
        }
    }
    
    func tapScrollViewsElement(name: String) {
        XCTContext.runActivity(named: "Tap button \(name)") { _ in
            XCUIApplication().scrollViews.otherElements.staticTexts[name].tap()
        }
    }

   func tapScrollViewsElemButon(name: String) {
        XCTContext.runActivity(named: "Tap button \(name)") { _ in
            XCUIApplication().scrollViews.otherElements.buttons[name].tap()
        }
    }
    
    func tapScrollViewsElemField(name: String) {
          XCTContext.runActivity(named: "Tap button \(name)") { _ in
            XCUIApplication().scrollViews.otherElements.textFields[name].tap()
        }
    }
    
    func tapTableCell(name: String) {
        let tablesQuery = app.tables
        XCTContext.runActivity(named: "Tap button \(name)") { _ in
        tablesQuery.cells.containing(.staticText, identifier: name).children(matching: .button).element.tap()
        }
    }
    
    func tapTableTextField(name: String) {
        XCTContext.runActivity(named: "Tap TextField \(name)") { _ in
            XCUIApplication().tables.textFields[name].tap()
        }
    }
    
    func tapViewTextField(name: String) {
        let webViewsQuery = app.webViews.webViews
        XCTContext.runActivity(named: "Tap TextField \(name)") { _ in
            webViewsQuery.textFields[name].tap()
        }
    }
    
    func tapViewSecureTextField(name: String) {
         let webViewsQuery = app.webViews.webViews
          XCTContext.runActivity(named: "Tap TextField \(name)") { _ in
                      webViewsQuery.secureTextFields[name].tap()
        }
    }
   
    // Проверяем есть ли текст на экране
    func assertText(name: String){
        XCTContext.runActivity(named: "Assert text \(name)") { _ in
            XCTAssertTrue(app.staticTexts[name].exists)
        }
    }
    
    // Проверяем есть ли текст подсказки в поле/маска на экране
    func assertTextHints(name: String){
        XCTContext.runActivity(named: "Assert text \(name)") { _ in
            XCTAssertTrue(app.textFields[name].exists)
        }
    }
    
    // Проверяем есть ли текст на экране используеться если текст длинный
       func assertTextFull(name: String){
        let LongText = (name)
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", LongText)
        XCTContext.runActivity(named: "Assert text \(name)") { _ in XCTAssertTrue(app.staticTexts.element(matching: predicate).exists)
        }
    }
    
    // Проверяем есть ли текст на экране для всех остальных элементов
    func assertTextOther(name: String){
        XCTContext.runActivity(named: "Assert text \(name)") { _ in
            XCTAssertTrue(app.otherElements[name].exists)
        }
    }
        
    // Проверяем есть ли кнопка на экране
    func assertButton(name: String) {
        XCTContext.runActivity(named: "Assert button \(name)") { _ in
            XCTAssertTrue(app.buttons[name].exists)
        }
    }
    
    // Проверяем есть ли изображение на экране
    func assertImage(name: String) {
        XCTContext.runActivity(named: "Assert image \(name)") { _ in
            XCTAssertTrue(app.images[name].exists)
        }
    }
    
    //Свайп до нужного элемента в таблице
    func swipeForTable(name: String) {
        let check = app.tables.cells.containing(.staticText, identifier: name).children(matching: .button).element
          if waitFor(check, to: .appear) {
            app.tables.cells.containing(.staticText, identifier: name).children(matching: .button).element.tap()
          } else {
            swipeUp()
            swipeForTable(name: name)
        }
    }
    
    //Свайп до нужного текстового элемента
    func swipeForText(name: String) {
        let check = app.staticTexts[name]
          if waitFor(check, to: .appear) {
            app.staticTexts[name].firstMatch.tap()
          } else {
            swipeUp()
            swipeForText(name: name)
        }
    }
    
    // Свайп вверх
    func swipeUp() {
        app.swipeUp()
    }
    
    // Свайп вниз
    func swipeDown() {
        app.swipeDown()
    }
    
    // Свайп вниз от элемента (зажимает и тянет за него вниз)
    func swipeDownFromElement(name: String) {
        let firstCell = app.staticTexts[name]
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 100))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
    // Ожидаем появляение кнопки 20 сек
    func waitForButton(name: String) {
        waitForElementToAppear(app.buttons[name])
    }
    
    // Ожидаем появляение кнопки 5 сек
    func waitForButtonShort(name: String) {
        waitForElementToAppearShort(app.buttons[name])
    }
    
    // Ожидаем появление текста 20 сек
    func waitForText(name: String) {
        waitForElementToAppear(app.staticTexts[name])
    }
    
    // Ожидаем появление текста 5 минут
    func waitForLongText(name: String) {
        waitForElementToAppearLong(app.staticTexts[name])
    }
    
    // Ожидаем появление кнопки 5 минут
    func waitForLongButton(name: String) {
        waitForElementToAppearLong(app.buttons[name])
    }
    
    // Ожидаем появление текста 5 сек
    func waitForTextShort(name: String) {
        waitForElementToAppearShort(app.staticTexts[name])
    }
    
    // Ожидаем появление изображения
    func waitForImage(name: String) {
        waitForElementToAppear(app.images[name])
    }
    
    // Проверяем есть ли текст на системном алерте
    func assertTextOnAlert(name: String){
        addUIInterruptionMonitor(withDescription: "System alert") { (alert) -> Bool in
            if alert.staticTexts[name].exists {
                alert.staticTexts[name].tap()
            }
            return true
        }
    }
    
    // Проверяем есть ли кнопка на системном алерте
    func assertButtonOnAlert(name: String){
        addUIInterruptionMonitor(withDescription: "System alert") { (alert) -> Bool in
            if alert.buttons[name].exists {
                alert.buttons[name].tap()
            }
            return true
        }
    }

    func tapAnywhere() {
        app.tap()
    }
}
