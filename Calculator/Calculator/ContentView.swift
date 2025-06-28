//
//  ContentView.swift
//  Calculator
//
//  Created by mhaashim on 28/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var userText: String = ""
    
    var body: some View {
        VStack {
            Text("String Calulator")
                .font(.title)
            TextField("Enter string", text: $userText)
            Button("Caluclate", action: {
                print(userText)
            })
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
