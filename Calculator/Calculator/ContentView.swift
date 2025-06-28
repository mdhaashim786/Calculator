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
    @State var isCalculating: Bool = false
    
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
            
            // Calculate Button
            Button(action: calculateSum) {
                buttonView()
            }
            .disabled(isCalculating)
            .scaleEffect(isCalculating ? 0.95 : 1.0)
            .accessibilityIdentifier("calculate")
            
            if let myResult = result {
                resultView(result: myResult)
            }
            
            Spacer()
        }
        }
        .padding()
    }
    
    func calculateSum() {
        isCalculating = true
        
        // Add delay for animation effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            do {
                result = try viewModel.add(userText)
            } catch {
                showAlertWithTitle = (true, error.localizedDescription)
            }
            isCalculating = false
        }
    }
    
    func buttonView() -> some View {
        HStack(spacing: 12) {
            if isCalculating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            Text(isCalculating ? "Calculating..." : "Calculate Sum")
                .font(.headline)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(16)
    }
    
    func errorView() -> some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Error")
                    .font(.headline)
                    .foregroundColor(.red)
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red.opacity(0.8))
            }
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red.opacity(0.3), lineWidth: 1)
        )
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
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
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
