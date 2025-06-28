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
    @State var isCalculating: Bool = false
    @State private var errorMessage = ""
    @State private var showResultWihValue: (Bool, Int?) = (false, nil)
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.8),
                    Color.blue.opacity(0.6),
                    Color.indigo.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("String Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 25)
                
                VStack(spacing: 25) {
                    // Input Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Input String")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemGray6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(userText.isEmpty ? Color.gray.opacity(0.3) : Color.blue, lineWidth: 2)
                                )
                            
                            if userText.isEmpty {
                                Text("Enter your input here")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 15)
                            }
                            
                            TextEditor(text: $userText)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.clear)
                                .scrollContentBackground(.hidden)
                        }
                        .frame(height: 100)
                    }
                    
                    // Calculate Button
                    Button(action: calculateSum) {
                        buttonView()
                    }
                    .disabled(isCalculating)
                    .scaleEffect(isCalculating ? 0.95 : 1.0)
                    
                    // Result Section
                    if showResultWihValue.0 {
                        VStack(spacing: 15) {
                            if !errorMessage.isEmpty {
                                // Error Display
                                errorView()
                            } else if let result = showResultWihValue.1 {
                                // Success Display
                                resultView(result: result)
                            }
                        }
                    }
                    
                    // Clear Button
                    if showResultWihValue.0 {
                        Button(action: clearCalculator) {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.clockwise")
                                Text("Clear & Start Over")
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(25)
                .background(.ultraThinMaterial)
                .cornerRadius(24)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func clearCalculator() {
        withAnimation(.easeInOut) {
            userText = ""
            errorMessage = ""
            showResultWihValue = (false, nil)
        }
    }
    
    
    func calculateSum() {
        isCalculating = true
        errorMessage = ""
        // Add delay for animation effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            do {
                showResultWihValue = (true, try viewModel.add(userText))
            } catch {
                errorMessage = error.localizedDescription
                showResultWihValue = (true, nil)
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
