//
//  TripFlowViewModel.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import Foundation
import RealmSwift


extension TripFlowView {
    class ViewModel: ObservableObject {
        
        let realmManager = RealmManager.shared
        
        @MainActor
        func updateTripStatus(trip: Trip, status: Trip.Status) {
            
            do {
                try realmManager.realm?.write {
                    trip.status = status
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
