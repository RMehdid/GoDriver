//
//  TripRequest.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

extension TripRequestSheet {
    class ViewModel: ObservableObject {
        
        let tripManager = TripRepo.sharedTrip
        
        @MainActor
        func getTripRequest(_ id: ObjectId) {
            do {
                try tripManager.getTrip(id)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        @MainActor
        func acceptTrip(tripId: ObjectId) {
            do {
                try tripManager.acceptTrip(tripId)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        func rejectTrip(tripId: ObjectId) {
            do {
                try tripManager.rejectTrip()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
