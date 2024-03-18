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
        .background(Color(red: 247/255, green: 243/255, blue: 248/255))
    }
}

#Preview {
    TripHistoryView(trips: .init())
}
