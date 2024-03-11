//
//  DriverRepo.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import RealmSwift

enum GoError: Error {
    case realmClosed
    case userNotFound
}

class DriverRepo: RealmManager {
    
    static let sharedDriver = DriverRepo()
    
    @Published private(set) var driver: Driver?
    
    @MainActor
    func createDriver() async throws {
        
        await RealmManager.shared.initialize()
        
        guard let id = app.currentUser?.id else {
            throw GoError.userNotFound
        }
        
        let newDriver = Driver(id: id, fullname: "Samy Mehdid")
        
        try RealmManager.shared.write {
            self.driver = newDriver
            self.add(newDriver)
        }
    }
    
    @MainActor
    func getDriver() async {
        
        guard let id = app.currentUser?.id else {
            return
        }
        
        guard let realm = RealmManager.shared.realm else {
            await RealmManager.shared.initialize()
            return
        }
        
        self.driver = realm.object(ofType: Driver.self, forPrimaryKey: id)
        
        debugPrint("this is driver: " + driver.debugDescription)
    }
    
    @MainActor
    func updateDriverOnline(isOnline: Bool) throws {
        
        try RealmManager.shared.write {
            self.driver?.isOnline = isOnline
        }
    }
    
    @MainActor
    func assignTrip(_ id: ObjectId) throws {
        
        try RealmManager.shared.write {
            self.driver?.currentTripId = id
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func rejectTrip() throws {
        
        try RealmManager.shared.write {
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func assignTripRequest(_ id: ObjectId) throws {
        self.driver?.tripRequestId = id
    }
    
    @MainActor
    func updateFullname(_ fullname: String) throws {
        
        try RealmManager.shared.write {
            self.driver?.fullname = fullname
        }
    }
    
    @MainActor
    func updatePhoneNumber(_ phone: String) throws {
        
        try RealmManager.shared.write {
            self.driver?.phoneNumber = phone
        }
    }
    
    @MainActor
    func unAssignTrip() throws {
        try RealmManager.shared.write {
            self.driver?.currentTripId = nil
        }
    }
}
