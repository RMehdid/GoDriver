//
//  ContentView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var pickup = ""
    @State private var dropOff = ""
    var body: some View {
        VStack {
            TextField("pickup", text: $pickup)
            TextField("drop off", text: $dropOff)
            
            Button("Create") {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
