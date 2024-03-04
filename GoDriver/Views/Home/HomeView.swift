//
//  HomeView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI
import MapKit
import RealmSwift

struct HomeView: View {
    
    @StateObject var driver: Driver
    
    @State private var isOnline = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            Map(initialPosition: .automatic)
            
            VStack{
                VStack{
                    Text("Revenus du jour")
                        .font(.system(size: 14, weight: .regular))
                    
                    
                    Text("\(driver.revenue) DA")
                        .font(.system(size: 22, weight: .heavy))

                }
                .padding()
                .padding(.horizontal)
                .background(.yaDarkPurple)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                Spacer()
                
                Toggle("Online", isOn: $isOnline)
                    .padding()
                    .background(Color.white)
            }
        }
        .onAppear {
//            viewModel.getDriver(id: .generate())
        }
    }
}

#Preview {
    HomeView(driver: Driver())
}
