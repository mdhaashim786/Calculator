//
//  CalculatorApp.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI

@main
struct CalculatorApp: App {
    
    @StateObject var calculatorViewModel = CalculatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: calculatorViewModel)
        }
    }
}
