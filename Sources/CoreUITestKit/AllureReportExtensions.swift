//
// Copyright © 2023 LLC "Globus Media". All rights reserved.
//

import XCTest

// MARK: Методы для адаптации юай тестов к выгрузке в Allure ТестОпс
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

private func label(name: String, values: [String]) {
    values.forEach {
        XCTContext.runActivity(named: "allure.label.\(name): \($0)") { _ in }
    }
}

private func description(name: String, value: String) {
    XCTContext.runActivity(named: "allure.description:\(name): \(value)") { _ in }
}
