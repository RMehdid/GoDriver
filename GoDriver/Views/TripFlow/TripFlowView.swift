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
                
                Spacer()
                
                VStack{
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        VStack {
                            Text(trip.rider.fullname)
                            
                            HStack {
                                Image("ic_star")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Text("4.5")
                            }
                        }
                        
                        Image(systemName: "phone.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .padding(15)
                            .background(Color.green)
                            .clipShape(.circle)
                    }
                    
                    Button {
                        viewModel.updateTripStatus(trip: trip, status: nextStatus)
                    } label: {
                        Text(buttonTitle)
                            .font(.system(size: 17, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.yaPurple)
                            .cornerRadius(8)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    TripFlowView(trip: Trip(id: ObjectId("65e7638152e9471b77904173")))
}
