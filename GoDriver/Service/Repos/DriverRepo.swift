//
//  DriverRepo.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import RealmSwift

class DriverRepo: RealmManager {
    
    static let sharedDriver = DriverRepo()
    
    @Published private(set) var driver: Driver?
    
    @MainActor
    func createDriver() throws {
        guard let id = app.currentUser?.id else { return }
        
        let newDriver = Driver(id: id, fullname: "Samy Mehdid")
        
        try realm?.write {
            self.realm?.add(newDriver)
        }
    }
    
    @MainActor
    func getDriver() throws {
        guard let id = app.currentUser?.id else { return }
        
        self.driver = self.realm?.object(ofType: Driver.self, forPrimaryKey: id)
    }
    
    @MainActor
    func updateDriverOnline(isOnline: Bool) throws {
        try self.realm?.write {
            self.driver?.isOnline = isOnline
        }
    }
    
    @MainActor
    func assignTrip(_ id: ObjectId) throws {
        try self.realm?.write {
            self.driver?.currentTripId = id
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func rejectTrip() throws {
        try self.realm?.write {
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func assignTripRequest(_ id: ObjectId) throws {
        try self.realm?.write {
            self.driver?.tripRequestId = id
        }
    }
    
    @MainActor
    func updateFullname(_ fullname: String) throws {
        try self.realm?.write {
            self.driver?.fullname = fullname
        }
    }
    
    @MainActor
    func updatePhoneNumber(_ phone: String) throws {
        try self.realm?.write {
            self.driver?.phoneNumber = phone
        }
    }
}
