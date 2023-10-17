
import XCTest

// MARK: Методы для адаптации юай тестов к выгрузке в Allure ТестОпс
extension XCTestCase {
    /// Наименование модуля содержащего тесты. В случае чекаута - "Чекаут iOS Autotests"
    public func feature(_ values: String...) {
        label(name: "feature", values: values)
    }

    /// Наименование блока содержащего набор тестов. Например "Экран детализации"
    public func story(_ stories: String...) {
        label(name: "story", values: stories)
        deviceInfo()
    }
    
    public func tag(_ tag: String...) {
        label(name: "tag", values: tag)
    }

    /// В эту обертку заворачиваем логические блоки в тесте
    public func step(_ name: String, step: () -> Void) {
        XCTContext.runActivity(named: name) { _ in
            step()
        }
    }

    /// Модель девайса на котором тестируем. Пока данные - хардкод
    public func deviceInfo() {
        description(
            name: "Device info",
            value: "Model name: Iphone11, Version OS: iOS 16.2"
        )
    }
    
    /// Используем для получания скриншота с места падения теста
    public func takeScreenshot(name screenshotName: String? = nil) {
        let screenshot = XCUIScreen.main.screenshot()
        let attach = XCTAttachment(screenshot: screenshot, quality: .medium)
        attach.name = screenshotName ?? name + "_" + UUID().uuidString
        attach.lifetime = .keepAlways
        add(attach)
    }
}

extension XCTestCase {
    private func description(name: String, value: String) {
        XCTContext.runActivity(named: "allure.description:\(name): \(value)", block: { _ in })
    }

    private func label(name: String, values: [String]) {
        for value in values {
            XCTContext.runActivity(named: "allure.label.\(name):\(value)", block: { _ in })
        }
    }
}
