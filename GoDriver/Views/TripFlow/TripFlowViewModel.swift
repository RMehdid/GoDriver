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
        
        @Published var trip: Trip?
        
        private let realmManager = RealmManager.shared
        
        @MainActor
        func getTrip(_ id: ObjectId) {
            do {
                self.trip = try realmManager.getTrip(id: id)
            } catch {
                debugPrint("errorrrrr: " + error.localizedDescription)
            }
        }
        
        @MainActor
        func updateTripStatus() {
            do {
                try realmManager.realm?.write {
                    self.trip?.status.setNext()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
