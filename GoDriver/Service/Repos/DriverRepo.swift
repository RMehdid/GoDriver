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
        
        await self.initialize()
        
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        guard let id = app.currentUser?.id else {
            throw GoError.userNotFound
        }
        
        let newDriver = Driver(id: id, fullname: "Samy Mehdid")
        
        try realm.write {
            self.realm?.add(newDriver)
        }
    }
    
    @MainActor
    func getDriver() async throws {
        
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        guard let id = app.currentUser?.id else {
            throw GoError.userNotFound
        }
        
        self.driver = realm.object(ofType: Driver.self, forPrimaryKey: id)
        
        debugPrint(driver)
    }
    
    @MainActor
    func updateDriverOnline(isOnline: Bool) throws {
        
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        try realm.write {
            self.driver?.isOnline = isOnline
        }
    }
    
    @MainActor
    func assignTrip(_ id: ObjectId) throws {
        
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        try realm.write {
            self.driver?.currentTripId = id
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func rejectTrip() throws {
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        
        try realm.write {
            self.driver?.tripRequestId = nil
        }
    }
    
    @MainActor
    func assignTripRequest(_ id: ObjectId) throws {
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        try realm.write {
            self.driver?.tripRequestId = id
        }
    }
    
    @MainActor
    func updateFullname(_ fullname: String) throws {
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        try realm.write {
            self.driver?.fullname = fullname
        }
    }
    
    @MainActor
    func updatePhoneNumber(_ phone: String) throws {
        guard let realm = self.realm else {
            throw GoError.realmClosed
        }
        
        try realm.write {
            self.driver?.phoneNumber = phone
        }
    }
}
