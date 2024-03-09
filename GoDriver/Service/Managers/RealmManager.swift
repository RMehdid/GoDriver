//
//  RealmManager.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import RealmSwift

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
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
}
