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
                resultView(result: myResult)
            }
            
            Spacer()
        }
        .alert(isPresented: $showAlertWithTitle.0) {
            
            return Alert(title: Text(showAlertWithTitle.1), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
    
    func resultView(result: Int) -> some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Result")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            
            HStack {
                Text("\(result)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.green)
                Spacer()
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ContentView(viewModel: CalculatorViewModel())
}
