//
//  TripFlowView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI
import MapKit
import RealmSwift

struct TripFlowView: View {
    
    @ObservedRealmObject var trip: Trip
    
    @StateObject private var viewModel = ViewModel()
    
    var buttonTitle: String {
        switch trip.status {
        case .accepted:
            return "Go to client"
        case .toClient:
            return "Notify your arrival"
        case .arrivedClient:
            return "Start Trip"
        case .toDestination:
            return "Finish Ride"
        default: return ""
        }
    }
    
    var nextStatus: TripStatus {
        switch trip.status {
        case .pending:
            return .accepted
        case .accepted:
            return .toClient
        case .toClient:
            return .arrivedClient
        case .arrivedClient:
            return .toDestination
        case .toDestination:
            return .arrivedDestination
        case .arrivedDestination:
            return .arrivedDestination
        }
    }
    
    var body: some View {
        ZStack {
            Map(initialPosition: .automatic)
            
            VStack {
                TripInfoCard(trip: trip)
                    .padding()
                
                Spacer()
                
                VStack(spacing: 24){
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading){
                            if let rider = trip.rider {
                                Text(rider.fullname)
                            }
                            
                            HStack {
                                Image("ic_star")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Text("4.5")
                                    .font(.system(size: 14, weight: .regular))
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            // implement call function
                        } label: {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .padding(15)
                                .background(Color.green)
                                .clipShape(.circle)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Button {
                        viewModel.updateTripStatus(trip: trip, status: nextStatus)
                    } label: {
                        Text(buttonTitle)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.yaPurple)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .padding()
                .padding(.bottom, 32)
                .background(Color.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 16,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 16
                    )
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TripFlowView(trip: Trip(id: ObjectId("65e7638152e9471b77904173")))
}
