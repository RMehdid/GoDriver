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
        let driverManager = DriverRepo.sharedDriver
        
        @MainActor
        func getTrip(_ id: ObjectId) async {
            await tripManager.getTrip(id)
        }
        
        @MainActor
        func updateTripStatus() {
            do {
                if tripManager.trip?.status == .completed {
                    try driverManager.unAssignTrip()
                } else {
                    try tripManager.updateTripStatus()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
