//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI
import Foundation

protocol CalculatorViewModelProtocol: ObservableObject {
    func add(_ numbers: String) throws -> Int
}

// Custom error type for negative numbers
enum CalculatorError: Error, LocalizedError {
    case negativeNumbers([Int])
    case noNumberEntered
    
    var errorDescription: String? {
        switch self {
        case .negativeNumbers(let numbers):
            let numbersString = numbers.map(String.init).joined(separator: ", ")
            return "Negative numbers not allowed: \(numbersString)"
        case .noNumberEntered:
            return "Please enter valid input"
        }
    }
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    func add(_ numbers: String) throws -> Int {
        
        // Handle empty string
        guard !numbers.isEmpty else { return 0 }
        
        // To recognise the new line include "\\n"
        var allowedDelimiters = CharacterSet(charactersIn: ",\n")
        // TextField does not support multiline input. When we type \n in text field
        // it treats as "\" and "n". To escape the backslash it adds another "\n".
        // So removing that
        var numbersToProcess = numbers.replacingOccurrences(of: "\\n", with: "\n")
        
        // Check for custom delimiter
        if numbers.hasPrefix("//") {
            let components = numbersToProcess.components(separatedBy: "\n")
            if components.count >= 2 {
                // Extract custom delimiter from first line
                let customDelimiter = String(components[0].dropFirst(2))
                
                // Add custom delimiter to character set
                allowedDelimiters.insert(charactersIn: customDelimiter)
                
                // Use remaining string after delimiter definition
                numbersToProcess = components[1]
            }
        }
        
        let numberStrings = numbersToProcess.components(separatedBy: allowedDelimiters)
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        // Convert to integers
        let numbersArray = numberStrings.compactMap { Int($0) }
        
        if numbersArray.isEmpty {
            throw CalculatorError.noNumberEntered
        }
        
        // Check for negative numbers
        let negativeNumbers = numbersArray.filter { $0 < 0 }
        if !negativeNumbers.isEmpty {
            throw CalculatorError.negativeNumbers(negativeNumbers)
        }
        
        // Use higher order functions
        return numbersArray.reduce(0) { result, number in result + number }
    }
    
}
