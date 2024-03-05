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
                    
                    
                }
            }
        }
    }
}

#Preview {
    TripFlowView(trip: Trip(id: ObjectId("65e7638152e9471b77904173")))
}
