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
    func getTrip(_ id: ObjectId) throws {
        self.trip = self.realm?.object(ofType: Trip.self, forPrimaryKey: id)
    }
    
    @MainActor
    func acceptTrip(_ id: ObjectId) throws {
        
        try DriverRepo.sharedDriver.assignTrip(id)
        
        try self.realm?.write {
            self.trip?.status = .accepted
        }
    }
    
    @MainActor
    func rejectTrip() throws {
        try DriverRepo.sharedDriver.rejectTrip()
    }
    
    @MainActor
    func updateTripStatus() throws {
        try self.realm?.write {
            self.trip?.status.setNext()
        }
    }
    
    // TODO: - remove this after have been completed
    @MainActor
    func createTripRequest() throws {
        let newTripRequest = Trip(id: .generate())
        
        let rider = Rider(_id: "65e836c6f4c9cfbe895f8b04")
        
        try self.realm?.write {
            self.realm?.add(rider)
        }
        
        try self.realm?.write {
            self.realm?.add(newTripRequest)
            rider.trips.append(newTripRequest)
            try DriverRepo.sharedDriver.assignTripRequest(newTripRequest._id)
        }
    }
}