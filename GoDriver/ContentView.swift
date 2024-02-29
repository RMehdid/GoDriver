//
//  ContentView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI
import MapKit
import RealmSwift

struct ContentView: View {
    
//    @ObservedResults(Driver.self) var users
    
    var body: some View {
        ZStack(alignment: .bottom){
            Map(initialPosition: .automatic)
            
            VStack{
                VStack{
                    Text("Revenus du jour")
                        .font(.system(size: 14, weight: .regular))
                    Text("")
                        .font(.system(size: 22, weight: .heavy))
                }
                .padding()
                .padding(.horizontal)
                .background(.yaDarkPurple)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .ignoresSafeArea()
                    .frame(height: 100)
                    .overlay {
                        Text("Yo")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
