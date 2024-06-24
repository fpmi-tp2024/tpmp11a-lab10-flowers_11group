//
//  flowersTests.swift
//  flowersTests
//
//  Created by Стеша Колачевская on 24.06.24.
//

import XCTest
@testable import flowers

final class flowersTests: XCTestCase {

    var registrationView: RegistrationView!

    override func setUpWithError() throws {
        // Инициализация объекта RegistrationView перед каждым тестом
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        registrationView = storyboard.instantiateViewController(identifier: "RegistrationView") as? RegistrationView
        registrationView.loadViewIfNeeded() // Загружаем представление для тестирования
    }

    override func tearDownWithError() throws {
        // Очистка после каждого теста
        registrationView = nil
    }

    func testExample() throws {
        // Пример функционального тестового случая
        // Используйте XCTAssert и связанные функции для проверки ваших тестов
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // Пример тестового случая для измерения производительности
        measure {
            // Код, время выполнения которого нужно измерить
        }
    }

    // Пример теста для проверки заполнения полей
    func testSignUpWithEmptyFields() {
        registrationView.login.text = ""
        registrationView.password.text = ""
        registrationView.rpassword.text = ""
        registrationView.address.text = ""

        registrationView.signUpClick(self)

        XCTAssertEqual(registrationView.resultLabel.text, "Неверные данные!")
    }

    func testSignUpWithMismatchedPasswords() {
        registrationView.login.text = "testUser"
        registrationView.password.text = "password123"
        registrationView.rpassword.text = "password321"
        registrationView.address.text = "Minsk"

        registrationView.signUpClick(self)

        XCTAssertEqual(registrationView.resultLabel.text, "Неверные данные!")
    }

    func testSignUpWithExistingLogin() {
        // Предположим, что у нас уже есть пользователь с логином "existingUser"
        let path = Bundle.main.path(forResource: "userData", ofType: "plist")
        let plist = NSMutableDictionary(contentsOfFile: path!)
        plist?.setObject("password", forKey: "existingUser" as NSCopying)
        plist?.write(toFile: path!, atomically: true)

        registrationView.login.text = "existingUser"
        registrationView.password.text = "password123"
        registrationView.rpassword.text = "password123"
        registrationView.address.text = "Minsk"

        registrationView.signUpClick(self)

        XCTAssertEqual(registrationView.resultLabel.text, NSLocalizedString("Login unavailable!", comment: ""))
    }

    func testSuccessfulSignUp() {
        registrationView.login.text = "newUser"
        registrationView.password.text = "password123"
        registrationView.rpassword.text = "password123"
        registrationView.address.text = "Minsk"

        registrationView.signUpClick(self)

        XCTAssertEqual(registrationView.resultLabel.text, "Registrate succesfully!")

        // Проверяем, что данные были сохранены правильно
        let path = Bundle.main.path(forResource: "userData", ofType: "plist")
        let plist = NSMutableDictionary(contentsOfFile: path!)
        let savedPassword = plist?.value(forKey: "newUser") as? String
        XCTAssertEqual(savedPassword, "password123")
    }
}
