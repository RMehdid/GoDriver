//
//  TripHistoryCard.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import SwiftUI
import RealmSwift

struct TripHistoryCard: View {
    
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                VStack(alignment: .leading, spacing: 12){
                    Text("ID: \(trip._id)")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(trip.createdAt.formatDate())
                        .font(.system(size: 14, weight: .regular))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 12){
                    Text("\(trip.price) DA")
                        .font(.system(size: 18, weight: .semibold))
                    
                    categoryLabelBuilder(category: trip.category)
                }
            }
            
            Divider()
                .frame(height: 1)
            
            VStack(alignment: .leading, spacing: 0){
                HStack(spacing: 8){
                    Image("ic_round_start")
                        .resizable()
                        .frame(width: 16, height: 28)
                    
                    VStack(alignment: .leading){
                        Text(trip.pickup)
                            .font(.system(size: 17, weight: .bold))
                        Text(trip.pickup)
                            .font(.system(size: 14, weight: .regular))
                    }
                }
                
                HStack(spacing: 8){
                    Image("ic_round_final")
                        .resizable()
                        .frame(width: 16, height: 52)
                    
                    VStack(alignment: .leading){
                        Text(trip.dropOff)
                            .font(.system(size: 17, weight: .bold))
                        Text(trip.dropOff)
                            .font(.system(size: 14, weight: .regular))
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
        .background(Color.white)
        .clipShape(
            .rect(cornerRadius: 8)
        )
    }
    
    @ViewBuilder
    private func categoryLabelBuilder(category: Trip.Category) -> some View {
        Text(category.rawValue)
            .font(.system(size: 12, weight: .semibold))
            .padding(.horizontal, 8)
            .background(Color.yaDarkPurple)
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    TripHistoryCard(trip: Trip(id: ObjectId("65e8373bdd4e088a23176b9d")))
}
