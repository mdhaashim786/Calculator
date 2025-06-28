//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI

protocol CalculatorViewModelProtocol: ObservableObject {
    func add(_ numbers: String) -> Int
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    func add(_ numbers: String) -> Int {
        print(numbers)
        return Int(numbers) ?? 0
    }
    
}
