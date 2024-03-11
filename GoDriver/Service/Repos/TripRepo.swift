//
//  TripRepo.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import RealmSwift

class TripRepo: RealmManager {
    
    static let sharedTrip = TripRepo()
    
    @Published private(set) var trip: Trip?
    
    @MainActor
    func getTrip(_ id: ObjectId) async {
        self.trip = RealmManager.shared.realm?.object(ofType: Trip.self, forPrimaryKey: id)
        debugPrint(trip)
    }
    
    @MainActor
    func acceptTrip(_ id: ObjectId) throws {
        
        try DriverRepo.sharedDriver.assignTrip(id)
        
        try RealmManager.shared.write {
            self.trip?.status = .accepted
        }
    }
    
    @MainActor
    func rejectTrip() throws {
        try DriverRepo.sharedDriver.rejectTrip()
    }
    
    @MainActor
    func updateTripStatus() throws {
        try RealmManager.shared.write {
            self.trip?.status.setNext()
        }
    }
    
    // TODO: - remove this after have been completed
    @MainActor
    func createTripRequest() throws {
        let newTripRequest = Trip(id: .generate())
        
        let rider = Rider(_id: "65e836c6f4c9cfbe895f8b05")
        
        try RealmManager.shared.write {
            self.add(rider)
        }
        
        try RealmManager.shared.write {
            RealmManager.shared.add(newTripRequest)
            rider.trips.append(newTripRequest)
            try DriverRepo.sharedDriver.assignTripRequest(newTripRequest._id)
        }
    }
}
