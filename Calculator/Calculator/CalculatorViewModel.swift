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
        let allowedDelimiters = CharacterSet(charactersIn: ",\\n")
        let numbersToProcess = numbers
        
        let numberStrings = numbersToProcess.components(separatedBy: allowedDelimiters)
        
        // Convert to integers
        let numbersArray = numberStrings.compactMap { Int($0) }
        
        var sumOfNumbers = 0
        
        for num in numbersArray {
            sumOfNumbers += num
        }
        
        return sumOfNumbers
    }
    
}
