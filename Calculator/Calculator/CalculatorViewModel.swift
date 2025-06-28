//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI
import Foundation

protocol CalculatorViewModelProtocol: ObservableObject {
    func add(_ numbers: String) -> Int
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    func add(_ numbers: String) -> Int {
        
        // Handle empty string
        guard !numbers.isEmpty else { return 0 }
        
        // To recognise the new line include "\\n"
        var allowedDelimiters = CharacterSet(charactersIn: ",\\n")
        var numbersToProcess = numbers
        
        // Check for custom delimiter
        if numbers.hasPrefix("//") {
            let components = numbers.components(separatedBy: "\\n")
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
        
        // Convert to integers
        let numbersArray = numberStrings.compactMap { Int($0) }
        
        // Use higher order functions
        return numbersArray.reduce(0) { result, number in result + number }
    }
    
}
