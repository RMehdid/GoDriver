//
//  HomeView.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import SwiftUI
import RealmSwift
import MapKit

struct HomeView: View {
    
    @ObservedRealmObject var driver: Driver
    
    @StateObject private var viewModel = ViewModel()
    
    @State var isOnline: Bool
    
    init(driver: Driver) {
        self._driver = ObservedRealmObject(wrappedValue: driver)
        self._isOnline = State(initialValue: driver.isOnline)
    }
    
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
                .background(Color.yaDarkPurple)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                Spacer()
                
                Toggle("Online", isOn: $isOnline)
                    .padding()
                    .background(Color.white)
                    .onChange(of: isOnline) { _, newValue in
                        viewModel.updateDriverOnline(isOnline: newValue)
                    }
                    .onChange(of: driver.isOnline) { _, newValue in
                        isOnline = newValue
                    }
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

