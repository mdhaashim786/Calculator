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
    
    @State var showAlertWithTitle: (Bool, String) = (false,"")
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("String Calculator")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Enter numbers ", text: $userText)
                .accessibilityIdentifier("numbersTextField")
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Calculate", action: {
                do {
                    result = try viewModel.add(userText)
                } catch {
                    showAlertWithTitle = (true, error.localizedDescription)
                }
            })
            .accessibilityIdentifier("calculate")
            
            if let myResult = result {
                Text("Result \(myResult)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            
            Spacer()
        }
        .alert(isPresented: $showAlertWithTitle.0) {
            
            return Alert(title: Text(showAlertWithTitle.1), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: CalculatorViewModel())
}
