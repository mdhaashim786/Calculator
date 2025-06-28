//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by mhaashim on 28/06/25.
//

import XCTest

final class CalculatorUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAddition() throws {
        // UI tests must launch the application that they test.
        app.launch()

        enterTextInTextField(textToBeEntered: "1,2")
        clickCalculateButton()
       
        let resultField = app.staticTexts["Result 3"]
        XCTAssertEqual(resultField.exists, true)
    }
    
    @MainActor
    func testNegativeNumbers() throws {
        // UI tests must launch the application that they test.
        app.launch()

        enterTextInTextField(textToBeEntered: "-3,4")
        clickCalculateButton()
       
        let resultField = app.staticTexts["Negative numbers not allowed: -3"]
        XCTAssertEqual(resultField.exists, true)
        
        let OkButton = app.buttons["OK"]
        XCTAssertEqual(OkButton.exists, true)
        OkButton.tap()
    }
    
    func enterTextInTextField(textToBeEntered: String) {
        let textFieldToEnter = app.textFields["numbersTextField"]
        XCTAssertEqual(textFieldToEnter.exists, true)
        textFieldToEnter.tap()
        textFieldToEnter.typeText(textToBeEntered)
    }
    
    func clickCalculateButton() {
        let calculateButton = app.buttons["calculate"]
        XCTAssertEqual(calculateButton.exists, true)
        calculateButton.tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
