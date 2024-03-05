//
//  RealmManager.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    static var shared = RealmManager()
    @Published var driver: Driver?
    
    private(set) var realm: Realm?
    
    @MainActor
    func initialize() async {
        
        do {
            guard var flexSyncConfig = app.currentUser?.flexibleSyncConfiguration() else { return }
            flexSyncConfig.objectTypes = [Driver.self, Trip.self]
            flexSyncConfig.schemaVersion = 0
            
            let realm = try await Realm(configuration: flexSyncConfig)
            
            
            let subscriptions = realm.subscriptions
            
            try await subscriptions.update {
                if let selfSub = subscriptions.first(named: "userDriver") {
                    print("Replacing subscription for userDriver")
                    selfSub.updateQuery(toType: Driver.self)
                } else {
                    print("Appending subscription for userDriver")
                    subscriptions.append(QuerySubscription<Driver>(name: "userDriver"))
                }
                
                if let tripSub = subscriptions.first(named: "driverTrips") {
                    print("Replacing subscription for driverTrips")
                    tripSub.updateQuery(toType: Trip.self)
                } else {
                    print("Appending subscription for driverTrips")
                    subscriptions.append(QuerySubscription<Trip>(name: "driverTrips"))
                }
            }
            print("Successfully opened realm: \(realm)")
            
            self.realm = realm
            
            try self.getDriver()
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func login(email: String, password: String) async throws {
        let _ = try await app.login(credentials: .emailPassword(email: email, password: password))
        await initialize()
    }
    
    func signUp(email: String, password: String) async throws {
        try await app.emailPasswordAuth.registerUser(email: email, password: password)
        try await self.login(email: email, password: password)
        try await self.createDriver()
    }
    
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
    func getTrip(id: ObjectId) throws -> Trip? {
        return self.realm?.object(ofType: Trip.self, forPrimaryKey: id)
    }
    
    @MainActor
    func createTrip() throws {
        
        let newTrip = Trip(id: ObjectId("65e7638152e9471b77904173"))
        
        try realm?.write {
            self.realm?.add(newTrip)
        }
    }
}
