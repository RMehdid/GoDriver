//
//  TripHistoryView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import SwiftUI
import RealmSwift

struct TripHistoryView: View {
    
    @ObservedRealmObject var trips: RealmSwift.List<Trip>
    
    var body: some View {
        VStack(spacing: 16){
            ScrollView(showsIndicators: false) {
                ForEach(trips) { trip in
                    TripHistoryCard(trip: trip)
                }
            }
        }
    }
}

#Preview {
    TripHistoryView(trips: .init())
}
