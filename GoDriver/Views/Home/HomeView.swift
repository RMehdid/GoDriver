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
    
    var statusTitle: String {
        if driver.tripRequestId != nil {
            return "New request recieved"
        } else {
            if isOnline {
                return "You are in service"
            } else {
                return "You are out of service"
            }
        }
    }
    
    init(driver: Driver) {
        self._driver = ObservedRealmObject(wrappedValue: driver)
        self._isOnline = State(initialValue: driver.isOnline)
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                ZStack(alignment: .bottom){
                    Map(initialPosition: .automatic)
                        .overlay {
                            if !isOnline {
                                Color.black.opacity(0.2)
                                    .ignoresSafeArea()
                            }
                        }
                    
                    VStack(spacing: 0){
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
                        
                        Toggle(statusTitle, isOn: $isOnline)
                            .font(.system(size: 17, weight: .bold))
                            .padding()
                            .onChange(of: isOnline) { _, newValue in
                                viewModel.updateDriverOnline(isOnline: newValue)
                            }
                            .onChange(of: driver.isOnline) { _, newValue in
                                isOnline = newValue
                            }
                            .background(.white)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 20
                                )
                            )
                        
                        if let tripRequestId = driver.tripRequestId {
                            TripRequestSheet(id: tripRequestId)
                        }
                    }
                }
                .tabItem {
                    Label {
                        Text("Status")
                    } icon: {
                        Image("ic_power")
                    }
                }
                .toolbarBackground(.white, for: .tabBar)
                
                ZStack {
                    
                }
                .tabItem {
                    Label {
                        Text("Courses")
                    } icon: {
                        Image("ic_pin")
                    }
                }
                
                ZStack{
                    
                }
                .tabItem {
                    Label {
                        Text("Revenue")
                    } icon: {
                        Image("ic_coins")
                    }
                }
                
                ZStack {
                    ProfileView(driver: driver)
                }
                .tabItem {
                    Label {
                        Text("Plus")
                    } icon: {
                        Image("ic_burger")
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView(driver:  Driver(id: "10202", fullname: "Samy H"))
}

