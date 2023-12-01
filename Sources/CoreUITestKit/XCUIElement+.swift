
import XCTest
import Foundation

extension XCUIElement {
    public var dsl_exists: Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на отображение") { _ in
            return exists
        }
    }
    
    public var dsl_isHittable: Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на готовность нажатия") { _ in
            return isHittable
        }
    }
    
    public var dsl_isEnabled: Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на доступность") { _ in
            return isEnabled
        }
    }
    
    public var dsl_isSelected: Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на выбираемость") { _ in
            return isSelected
        }
    }
    
    public var dsl_stringValue: String? {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Получить значение элемента '\(String(describing: resourceName))'") { _ in
            return self.value as? String
        }
    }

    public var dsl_label: String {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Получить лэйбл элемента '\(String(describing: resourceName))'") { _ in
            return self.label
        }
    }
    
    public var dsl_placeholderValue: String? {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Получить плейсхолдер элемента '\(String(describing: resourceName))'") { _ in
            return self.placeholderValue
        }
    }
    
    /// Определяет установлен ли FirstResponder у конкретного элемента. Применимо для текстфилда
    public func dsl_hasFocus() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Определение установлен ли фокус у элемента \(String(describing: resourceName))") { _ in
            return (value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        }
    }
    
    /// Выбор  элемента по тексту в пикере
    public func dsl_adjust(toPickerWheelValue: String, file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Тап по тексту '\(toPickerWheelValue)' в  елементе \(String(describing: resourceName))") { _ in
            adjust(toPickerWheelValue: toPickerWheelValue)
        }
    }
    
    /// Выбор раскладки клавиатуры устройства
    public func dsl_selectKeyboardLayout(_ keyboardLayout: KeyboardLayout) -> XCUIElement {
        switch keyboardLayout {
        case .RU:
            return  XCTContext.runActivity(named: "Выбор русской раскладки клавиатуры") { _ in
                let button = buttons.element(matching: NSPredicate(format: "value like 'Русская*'")).firstMatch
                return button
            }
        case .ENG:
            return  XCTContext.runActivity(named: "Выбор английской раскладки клавиатуры") { _ in
                let button = buttons.element(matching: NSPredicate(format: "value like 'English (US)*'")).firstMatch
                return button
            }
        case .Number:
            return  XCTContext.runActivity(named: "Выбор цифровой раскладки клавиатуры") { _ in
                return keys["more"].firstMatch
            }
        }
    }
    
    @discardableResult
    public func dsl_waitForExistence(timeout: Double) -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Ожидание элемента \(String(describing: resourceName))") { _ in
            return waitForExistence(timeout: timeout)
        }
    }
    
    @discardableResult
    public func dsl_waitForHidden(timeout: Double) -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Подождать, пока элемент \(String(describing: resourceName)) не скроется") { _ in
            let expectation = XCTNSPredicateExpectation(
                predicate: NSPredicate(format: "exists == false"),
                object: self
            )
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            let checkHidden = !self.dsl_exists || result == .completed
            return checkHidden
        }
    }
    
    @discardableResult
    public func dsl_waitForHittable(timeout: Double, file: StaticString = #file, line: UInt = #line) -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Подождать, пока элемент \(String(describing: resourceName)) станет кликабельным") { _ in
            let expectation = XCTNSPredicateExpectation(
                predicate: NSPredicate(format: "isHittable == true"),
                object: self
            )
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            return self.dsl_isHittable || (result == .completed)
        }
    }

    public func dsl_typeText(_ text: String, needWait: Bool = false, file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Ввод текста \(text) в \(String(describing: resourceName))") { _ in
            if needWait {
                guard dsl_waitForHittable(timeout: 5) else {
                    XCTFail(
                        "Элемент \(String(describing: resourceName)) не готов для нажатия",
                        file: file,
                        line: line
                    )
                    return
                }
                XCTContext.runActivity(named: "Ввод текста \(text)") { _ in
                    typeText(text)
                }
            } else {
                XCTContext.runActivity(named: "Ввод текста \(text)") { _ in
                    typeText(text)
                }
            }
        }
    }
    
    public func dsl_tap(needWait: Bool = false, file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Тап по элементу \(String(describing: resourceName))") { _ in
            if needWait {
                guard dsl_waitForHittable(timeout: 5) else {
                    XCTFail(
                        "Элемент \(String(describing: resourceName)) не готов для нажатия",
                        file: file,
                        line: line
                    )
                    return
                }
                XCTContext.runActivity(named: "Тап") { _ in
                    tap()
                }
            } else {
                XCTContext.runActivity(named: "Тап") { _ in
                    tap()
                }
            }
        }
    }
    
    public func dsl_doubleTap(needWait: Bool = false, file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Двойной Тап по элементу \(String(describing: resourceName))") { _ in
            if needWait {
                guard dsl_waitForHittable(timeout: 5) else {
                    XCTFail(
                        "Элемент \(String(describing: resourceName)) не готов для нажатия",
                        file: file,
                        line: line
                    )
                    return
                }
                XCTContext.runActivity(named: "Двойной Тап") { _ in
                    doubleTap()
                }
            } else {
                XCTContext.runActivity(named: "Двойной Тап") { _ in
                    doubleTap()
                }
            }
        }
    }
    
    ///  Принудительный Тап  по координатам
    public func dsl_forceTap(file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Тап по скрытому элементу \(String(describing: resourceName))") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0)).tap()
        }
    }
    
    ///  Мульти Тап
    public func dsl_tap(withNumberOfTaps: Int) {
        let resourceName = self.description
        
        XCTContext.runActivity(named: "Тап по элементу \(String(describing: resourceName)) \(withNumberOfTaps) раз(а)") { _ in
            tap(withNumberOfTaps: withNumberOfTaps, numberOfTouches: 1)
        }
    }
    
    /// Стандартный свайп
    public func dsl_swipe(_ direction: Direction) {
        switch direction {
        case .up:
            XCTContext.runActivity(named: "Свайп вверх") { _ in
                swipeUp()
            }
        case .down:
            XCTContext.runActivity(named: "Свайп вниз") { _ in
                swipeDown()
            }
        case .left:
            XCTContext.runActivity(named: "Свайп влево") { _ in
                swipeLeft()
            }
        case .right:
            XCTContext.runActivity(named: "Свайп вправо") { _ in
                swipeRight()
            }
        }
    }
    
    /// Свайп n-раз
    public func dsl_swipe(_ direction: Direction, _ times: Int, velocity: XCUIGestureVelocity = .default ) {
        switch direction {
        case .up:
            XCTContext.runActivity(named: "Свайп вверх \(times) раз") { _ in
                for _ in 0...times {
                    swipeUp(velocity: velocity)
                }
            }
        case .down:
            XCTContext.runActivity(named: "Свайп вниз \(times) раз") { _ in
                for _ in 0...times {
                    swipeDown(velocity: velocity)
                }
            }
        case .left:
            XCTContext.runActivity(named: "Свайп влево \(times) раз") { _ in
                for _ in 0...times {
                    swipeLeft(velocity: velocity)
                }
            }
        case .right:
            XCTContext.runActivity(named: "Свайп вправо \(times) раз") { _ in
                for _ in 0...times {
                    swipeRight(velocity: velocity)
                }
            }
        }
    }
    
    /// открывыет диплинк из Сафари браузера
    public func dsl_openDeeplink(deeplink: String) {
        XCTContext.runActivity(named: "Открытие диплинка '\(String(describing: deeplink))' через Safari браузер") { _ in
            let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
            safari.launch()
            _ = safari.wait(for: .runningForeground, timeout: 30)
            if #available(iOS 15, *) {
                safari.textFields["Адрес"].dsl_tap()
            } else {
                safari.otherElements["URL"].dsl_tap()
            }
            
            safari.dsl_typeText("tututransportapp://\(deeplink)/")
            safari.dsl_typeText("\n")
            safari.buttons["Открыть"].dsl_tap()
        }
    }
    
    /// Очищает текст в текстовом поле через вставку пустого текста
    public func dsl_clearText() {
        let resourceName = self.description
        XCTContext.runActivity(named: "Очистка текста в элементе \(String(describing: resourceName))") { _ in
            guard let stringValue = self.dsl_stringValue else { return }
            var deleteString = String()
            for _ in stringValue {
                deleteString += XCUIKeyboardKey.delete.rawValue
            }
            self.dsl_typeText(deleteString)
        }
    }

    /// Очищает поле и вставляет новый текст в текстовое поле через буфер
    public func dsl_setText(text: String, needDoubleTap: Bool = true) {
        let app = XCUIApplication()
        let resourceName = self.description
        XCTContext.runActivity(named: "Очищает поле и вставляет новый текст в текстовое поле \(String(describing: resourceName))") { _ in
            if needDoubleTap {
                dsl_doubleTap()
            } else {
                dsl_tap()
            }
            dsl_clearText()

            // Ci капризничает, и в некоторых словах делает автозамену -> тесты падают
            // Для стабильности, на 16 оси вставляем текст а не печатаем
            if #available(iOS 16.0, *) {
                UIPasteboard.general.string = text
                dsl_doubleTap()
                XCTAssertTrue(
                    app.menuItems["Вставить"].dsl_waitForExistence(timeout: 1),
                    "Не удалось вставить текст \(text)"
                )
                app.menuItems["Вставить"].dsl_tap()
                app.toolbars.buttons["Готово"].firstMatch.dsl_tap()
            } else {
                app.dsl_typeText(text)
                app.dsl_swipe(.down)
            }
        }
    }
    
    /// ввод текста через клавиатуру устройства
    public func dsl_typeTextFromKeyboard(text: String, keyboardLayout: XCUIElement.KeyboardLayout) {
        XCTContext.runActivity(named: "Ввод текста '\(String(describing: text))' через клавиатуру") {  _ in
            let app = XCUIApplication()
            dsl_tap()
            
            if keyboardLayout == .RU && app.dsl_selectKeyboardLayout(keyboardLayout).dsl_isHittable {
                app.dsl_selectKeyboardLayout(keyboardLayout).dsl_tap()
            }
            
            else if keyboardLayout == .ENG && app.dsl_selectKeyboardLayout(keyboardLayout).dsl_isHittable {
                app.dsl_selectKeyboardLayout(keyboardLayout).dsl_tap()
            }
            
            else if keyboardLayout == .Number && app.dsl_selectKeyboardLayout(keyboardLayout).dsl_isHittable {
                app.dsl_selectKeyboardLayout(keyboardLayout).dsl_tap()
            }
            
            for char in text {
                let key = app.keys[String(char)]
                key.dsl_tap()
            }
        }
    }
    
    /// Удаление текста через клавиатуру устройства
    public func dsl_clearTextFromKeyboard(file: StaticString = #file, line: UInt = #line) {
        let resourceName = self.description
        let app = XCUIApplication()
        XCTContext.runActivity(named: "Удаление текста '\(String(describing: resourceName))' через клавиатуру") {  _ in
            tap()
            guard let stringValue = value as? String else {
                XCTFail(
                    "Tried to clear and enter text into a non string value!",
                    file: file,
                    line: line
                )
                return
            }
            let isNotEmptyValue = !stringValue.isEmpty
            let isExistDeleteButton = app.keys["delete"].dsl_isHittable
            let shouldTapClearButton = isNotEmptyValue && isExistDeleteButton
            if shouldTapClearButton {
                for _ in 0 ..< stringValue.count {
                    app.keys["delete"].dsl_tap()
                }
            }
        }
    }

    /// Автоматический скролл до элемента
    /// Дистанция одной прокрутки - половина высоты элемента, к которому применяется метод
    /// - parameters:
    ///     - element: Искомый элемент.
    ///     - withDirection: Направление скролла
    public func dsl_scrollTo(element: XCUIElement, withDirection scrollDirection: GestureDirection, file: StaticString = #file, line: UInt = #line) {
        XCTContext.runActivity(named: "Скролл до элемента \(element)") { _ in
            let maxScrolls = 10
            for _ in 0 ..< maxScrolls {
                if element.dsl_waitForExistence(timeout: 3) && element.dsl_waitForHittable(timeout: 3) {
                    return
                }
                
                let startCoord = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
                let endCoord = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: scrollDirection == .up ? 1 : 0))
                startCoord.dsl_press(forDuration: 0, thenDragTo: endCoord)
            }
            XCTFail(
                "Не удалось доскроллить до элемента \(element) за \(maxScrolls) раз(а)",
                file: file,
                line: line
            )
        }
    }
    
    public enum KeyboardLayout: String {
        case RU
        case ENG
        case Number
    }
    
    /// Направление свайпа
    public enum Direction: Int {
        case up
        case down
        case left
        case right
    }
    
    /// Направление скролла
    public enum GestureDirection {
        case up, down
    }
    
    public enum Action: String {
        case exists
        case isHittable
        case isEnabled
        case isSelected
        case hasFocus
        case waitForExistence
        case waitForHidden
        case waitForHittable
        case waitForExistenceLong
        case waitForHiddenLong
        case waitForHittableLong
    }

    
    public func checkAction(_ action: Action) -> Bool {
        switch action {
        case .exists:
            return dsl_exists
        case .isHittable:
            return dsl_isHittable
        case .isEnabled:
            return dsl_isEnabled
        case .isSelected:
            return dsl_isSelected
        case .hasFocus:
            return dsl_hasFocus()
        case .waitForExistence:
            return dsl_waitForExistence(timeout: 5)
        case .waitForHidden:
            return dsl_waitForHidden(timeout: 5)
        case .waitForHittable:
            return dsl_waitForHittable(timeout: 5)
        case .waitForExistenceLong:
            return dsl_waitForExistence(timeout: 45)
        case .waitForHiddenLong:
            return dsl_waitForHidden(timeout: 45)
        case .waitForHittableLong:
            return dsl_waitForHittable(timeout: 45)
        }
    }
}
