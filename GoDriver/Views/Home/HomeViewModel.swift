//
//  HomeViewModel.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

extension HomeView {
    class ViewModel: ObservableObject {
        
        let tripManager = TripRepo.sharedTrip
        let driverManager = DriverRepo.sharedDriver
        
        @MainActor
        func updateDriverOnline(isOnline: Bool) {
            do {
                try driverManager.updateDriverOnline(isOnline: isOnline)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        func createTripRequest() {
            do {
                try tripManager.createTripRequest()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
