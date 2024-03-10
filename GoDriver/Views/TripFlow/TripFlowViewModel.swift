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
        
        let tripManager = TripRepo.sharedTrip
        
        @MainActor
        func getTrip(_ id: ObjectId) async {
            await tripManager.getTrip(id)
        }
        
        @MainActor
        func updateTripStatus() {
            do {
                try tripManager.updateTripStatus()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
