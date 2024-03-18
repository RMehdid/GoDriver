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
                ForEach(trips.groupedByDate.sorted(by: { $0.key > $1.key }), id: \.key) { dateString, trips in
                    VStack(alignment: .leading) {
                        Text(dateString)
                            .font(.headline)
                            .padding(8)
                        
                        ForEach(trips) {
                            TripHistoryCard(trip: $0)
                        }
                    }
                }
            }
        }
        .background(Color(red: 247/255, green: 243/255, blue: 248/255))
    }
}

#Preview {
    TripHistoryView(trips: .init())
}
