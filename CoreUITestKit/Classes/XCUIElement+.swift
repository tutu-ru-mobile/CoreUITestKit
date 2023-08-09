
import XCTest

extension XCUIElement {
    
    /// открывыет диплинк из Сафари браузера
    func openDeeplink(deeplink: String) {
        XCTContext.runActivity(named: "Открытие диплинка '\(String(describing: deeplink))' через Safari браузер") { _ in
            let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
            safari.launch()
            _ = safari.wait(for: .runningForeground, timeout: 30)
            if #available(iOS 15, *) {
                safari.textFields["Адрес"].tap()
            } else {
                safari.otherElements["URL"].tap()
            }
            
            safari.typeText("tututransportapp://\(deeplink)/")
            safari.typeText("\n")
            safari.buttons["Открыть"].tap()
        }
    }
    
    /// Очищает текст в текстовом поле через вставку пустого текста
    func clearText() {
        let resourceName = self.description
        XCTContext.runActivity(named: "Очистка текста в элементе \(String(describing: resourceName))") { _ in
            guard let stringValue = self.stringValue else { return }
            var deleteString = String()
            for _ in stringValue {
                deleteString += XCUIKeyboardKey.delete.rawValue
            }
            self.typeText(deleteString)
        }
    }
    
    /// Очищает поле и вставляет новый текст в текстовое поле через буфер
    func setText(text: String, needDoubleTap: Bool = true) {
        let app = XCUIApplication()
        let resourceName = self.description
        XCTContext.runActivity(named: "Очищает поле и вставляет новый текст в текстовое поле \(String(describing: resourceName))") { _ in
            if needDoubleTap {
                doubleTap()
            } else {
                tap()
            }
            clearText()
            
            // Ci капризничает, и в некоторых словах делает автозамену -> тесты падают
            // Для стабильности, на 16 оси вставляем текст а не печатаем
            if #available(iOS 16.0, *) {
                UIPasteboard.general.string = text
                doubleTap()
                XCTAssertTrue(
                    app.menuItems["Вставить"].waitForExistence(1),
                    "Не удалось вставить текст \(text)"
                )
                app.menuItems["Вставить"].tap()
                app.toolbars.buttons["Готово"].firstMatch.tap()
            } else {
                app.typeText(text)
                app.swipe(.down)
            }
        }
    }
    
    /// ввод текста через клавиатуру устройства
    func typeTextFromKeyboard(text: String, keyboardLayout: XCUIElement.KeyboardLayout) {
        XCTContext.runActivity(named: "Ввод текста '\(String(describing: text))' через клавиатуру") {  _ in
            let app = XCUIApplication()
            tap()
            
            if keyboardLayout == .RU && app.selectKeyboardLayout(keyboardLayout).isHittable() {
                app.selectKeyboardLayout(keyboardLayout).tap()
            }
            
            else if keyboardLayout == .ENG && app.selectKeyboardLayout(keyboardLayout).isHittable() {
                app.selectKeyboardLayout(keyboardLayout).tap()
            }
            
            else if keyboardLayout == .Number && app.selectKeyboardLayout(keyboardLayout).isHittable() {
                app.selectKeyboardLayout(keyboardLayout).tap()
            }
            
            for char in text {
                let key = app.keys[String(char)]
                key.tap()
            }
        }
    }
    
    /// Удаление текста через клавиатуру устройства
    func clearTextFromKeyboard() {
        let resourceName = self.description
        let app = XCUIApplication()
        XCTContext.runActivity(named: "Удаление текста '\(String(describing: resourceName))' через клавиатуру") {  _ in
            tap()
            guard let stringValue = value as? String else {
                XCTFail("Tried to clear and enter text into a non string value!")
                return
            }
            let isNotEmptyValue = !stringValue.isEmpty
            let isExistDeleteButton = app.keys["delete"].isHittable()
            let shouldTapClearButton = isNotEmptyValue && isExistDeleteButton
            if shouldTapClearButton {
                for _ in 0 ..< stringValue.count {
                    app.keys["delete"].tap()
                }
            }
        }
    }
    
    /// Возвращает содержимое текстового поля
    var stringValue: String? {
        self.value as? String
    }

    /// Определяет установлен ли FirstResponder у конкретного элемента. Применимо для текстфилда
    func hasFocus() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Определение установлен ли фокус у элемента \(String(describing: resourceName))") { _ in
            return (value(forKey: "hasKeyboardFocus") as? Bool) ?? false
        }
    }
    
    public enum KeyboardLayout: String {
        case RU
        case ENG
        case Number
    }
    
    
    /// Выбор раскладки клавиатуры устройства
    public func selectKeyboardLayout(_ keyboardLayout: KeyboardLayout) -> XCUIElement {
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
    
    public enum Action: String {
        case exists
        case isHittable
        case isEnabled
        case isSelected
        case waitForExistence
        case hasFocus
    }

    
    public func checkAction(_ action: Action) -> Bool {
        switch action {
        case .exists:
            return exists()
        case .isHittable:
            return isHittable()
        case .isEnabled:
            return isEnabled()
        case .isSelected:
            return isSelected()
        case .hasFocus:
            return hasFocus()
        case .waitForExistence:
            return waitForExistence(5)
        }
    }
    
    public enum Direction: Int {
        case up
        case down
        case left
        case right
    }
    
    /// Стандартный свайп
    func swipe(_ direction: Direction) {
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
    func swipe(_ direction: Direction, _ times: Int, velocity: XCUIGestureVelocity = .default ) {
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
    
    @discardableResult
    func exists() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на отображение") { _ in
            return exists
        }
    }
    
    @discardableResult
    func waitForExistence(_ timeout: Double) -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Ожидание элемента \(String(describing: resourceName))") { _ in
            return waitForExistence(timeout: timeout)
        }
    }
    
    @discardableResult
    func isHittable() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на готовность нажатия") { _ in
            return isHittable
        }
    }
    
    @discardableResult
    func isEnabled() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на доступность") { _ in
            return isEnabled
        }
    }
    
    @discardableResult
    func isSelected() -> Bool {
        let resourceName = self.description
        return XCTContext.runActivity(named: "Проверка элемента \(String(describing: resourceName)) на выбираемость") { _ in
            return isSelected
        }
    }
    
    func typeText(_ text: String) {
        let resourceName = self.description
        XCTContext.runActivity(named: "Ввод текста \(text) в \(String(describing: resourceName))") { _ in
            isHittable()
            typeText(text)
        }
    }
    
    func tap() {
        let resourceName = self.description
        XCTContext.runActivity(named: "Тап по элементу \(String(describing: resourceName))") { _ in
            isHittable()
            XCTContext.runActivity(named: "Тап") { _ in
                tap()
            }
        }
    }
    
    func doubleTap() {
        let resourceName = self.description
        XCTContext.runActivity(named: "Двойной Тап по элементу \(String(describing: resourceName))") { _ in
            isHittable()
            XCTContext.runActivity(named: "Тап") { _ in
                doubleTap()
            }
        }
    }
}
