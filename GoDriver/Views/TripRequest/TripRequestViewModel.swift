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
        
        @Published var trip: Trip?
        
        let realmManager = RealmManager.shared
        
        @MainActor
        func getTripRequest(_ id: ObjectId) {
            do {
                self.trip = try realmManager.getTrip(id: id)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        @MainActor
        func rejectTrip(tripId: ObjectId) {
            guard realmManager.driver?.tripRequestId == tripId else { return }
            
            do {
                try realmManager.realm?.write {
                    realmManager.driver?.tripRequestId = nil
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
