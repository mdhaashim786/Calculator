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
       
        let expectation = self.expectation(description: "Wait for delayed result")
        performDelayedResult { _ in
            let resultField = self.app.staticTexts["3"]
            XCTAssertEqual(resultField.exists, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
       
    }
    
    @MainActor
    func testNegativeNumbers() throws {
        // UI tests must launch the application that they test.
        app.launch()

        enterTextInTextField(textToBeEntered: "-3,4")
        clickCalculateButton()
       
        let expectation = self.expectation(description: "Wait for delayed result")
        performDelayedResult { _ in
            let errorField = self.app.staticTexts["Negative numbers not allowed: -3"]
            XCTAssertEqual(errorField.exists, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)

    }
    
    func enterTextInTextField(textToBeEntered: String) {
        let textFieldToEnter = app.textViews["numbersTextField"]
        XCTAssertEqual(textFieldToEnter.exists, true)
        textFieldToEnter.tap()
        textFieldToEnter.typeText(textToBeEntered)
    }
    
    func clickCalculateButton() {
        let calculateButton = app.buttons["calculate"]
        XCTAssertEqual(calculateButton.exists, true)
        calculateButton.tap()
    }
    
    func performDelayedResult(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            completion("Success")
        }
    }


    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
