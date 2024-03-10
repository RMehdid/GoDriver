//
//  RealmManager.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import RealmSwift
import Realm

class RealmManager: ObservableObject {
    
    static var shared = RealmManager()
    
    private(set) var realm: Realm?
    
    @MainActor
    func initialize() async {
        do {
            guard var flexSyncConfig = app.currentUser?.flexibleSyncConfiguration() else { return }
            flexSyncConfig.objectTypes = [Driver.self, Trip.self, Rider.self]
            flexSyncConfig.schemaVersion = 0
            
            var realm = try await Realm(configuration: flexSyncConfig)
            
            try await realm.setSubscriptions()
            
            print("Successfully opened realm: \(realm)")
            
            self.realm = realm
            
            await DriverRepo.sharedDriver.getDriver()
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func write<Result>(_ block: (() throws -> Result)) throws {
        
        if let realm = self.realm {
            try realm.write(block)
        }
    }
    
    @MainActor
    func get<Element, KeyType>(
        ofType type: Element.Type,
        forPrimaryKey key: KeyType
    ) -> Element? where Element : RealmSwiftObject {
        if let realm = self.realm {
            return realm.object(ofType: type, forPrimaryKey: key)
        } else {
            return nil
        }
    }
    
    @MainActor
    func add(_ object: Object) {
        if let realm = self.realm {
            realm.add(object)
        }
    }
}
