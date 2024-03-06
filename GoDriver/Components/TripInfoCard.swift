//
//  TripInfoCard.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI
import RealmSwift

struct TripInfoCard: View {
    
    @ObservedRealmObject var trip: Trip
    
    var progressTitles: (String, String, Int) {
        switch trip.status {
        case .accepted, .toClient:
            return (trip.pickup, "Pickup location", 1)
        case .arrivedClient:
            return (trip.dropOff, "Lieu de prise en charge", 2)
        case .toDestination, .arrivedDestination:
            return (trip.dropOff, "Destination", 2)
        default: return ("", "", 0)
        }
    }
    
    var body: some View {
        VStack(spacing: 16){
            HStack(alignment: .top){
                Image("ic_circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                
                VStack(alignment: .leading){
                    Text(progressTitles.0)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Text(progressTitles.1)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color(red: 217 / 255, green: 213 / 255, blue: 226 / 255))
                }
                
                Spacer()
                
                VStack(alignment: .trailing){
                    label("12:10")
                    
                    if progressTitles.2 == 2 {
                        label("5,7 km")
                    }
                }
                .foregroundStyle(.white)
            }
            
            HStack(spacing: 8){
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 24, height: 4)
                    .foregroundStyle(.white)
                    .opacity(progressTitles.2 == 1 ? 1 : 0.5)
                
                
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 24, height: 4)
                    .foregroundStyle(.white)
                    .opacity(progressTitles.2 == 2 ? 1 : 0.5)
            }
        }
        .padding()
        .background(Color.yaDarkPurple)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func label(_ value: String) -> some View {
        Text(value)
            .font(.system(size: 14, weight: .semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.4))
            .clipShape(.capsule)
    }
}

#Preview {
    TripInfoCard(trip: Trip(id: ObjectId("65e7638152e9471b77904173")))
}
