//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by mhaashim on 28/06/25.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let calculatorVM = CalculatorViewModel()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testAddition() throws {
        // Implement unit test cases
        
        let emptyString = try calculatorVM.add("")
        XCTAssertEqual(emptyString, 0)
        
        let singleDigitString = try calculatorVM.add("3")
        XCTAssertEqual(singleDigitString, 3)
        
        let twoNumbersString = try calculatorVM.add("1,5")
        XCTAssertEqual(twoNumbersString, 6)
        
        let multipleNumbersString = try calculatorVM.add("1,2,3,4,5")
        XCTAssertEqual(multipleNumbersString, 15)
        
        let numbersWithNewLine = try calculatorVM.add("3\n4")
        XCTAssertEqual(numbersWithNewLine, 7)
        
        let numbersWithTwoDelimiters = try calculatorVM.add("1\n2,3")
        XCTAssertEqual(numbersWithTwoDelimiters, 6)
        
        let semiColonAsCustomDelimiter = try calculatorVM.add("//;\n1;2")
        XCTAssertEqual(semiColonAsCustomDelimiter, 3)

    }
    
    func testAdditionOfNegativeNumbers() throws {
        
        XCTAssertThrowsError(try calculatorVM.add("1,-2,3")) { error in
            XCTAssertEqual(error.localizedDescription, "Negative numbers not allowed: -2")
        }
        
        XCTAssertThrowsError(try calculatorVM.add("1,-2,3,-5")) { error in
            XCTAssertEqual(error.localizedDescription, "Negative numbers not allowed: -2, -5")
        }
        
        XCTAssertThrowsError(try calculatorVM.add("Incubyte")) { error in
            XCTAssertEqual(error.localizedDescription, "Please enter only numbers")
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
