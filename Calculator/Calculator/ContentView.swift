//
//  ContentView.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI

struct ContentView<ViewModel: CalculatorViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var userText: String = ""
    @State var result: Int?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Enter numbers ", text: $userText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Calculate", action: {
                result = viewModel.add(userText)
            })
            
            if let myResult = result {
                Text("Result \(myResult)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: CalculatorViewModel())
}
