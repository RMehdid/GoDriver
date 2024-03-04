//
//  RealmManager.swift
//  GoDriver
//
//  Created by Samy Mehdid on 1/3/2024.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    let app: App
    
    static var shared = RealmManager()
    @Published var user: User?
    @Published var driver: Driver?
    
    private(set) var realm: Realm?
    
    init() {
        self.app = App(id: "application-0-wwixx")
    }
    
    @MainActor
    func initialize() async throws {
        
        
        self.user = try await app.login(credentials: .anonymous)
        
        guard let userId = self.user?.id else { return }
        
        do {
            guard var flexSyncConfig = user?.flexibleSyncConfiguration() else { return }
            flexSyncConfig.objectTypes = [Driver.self]
            flexSyncConfig.schemaVersion = 2
            flexSyncConfig.migrationBlock = { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    
                }
            }
            
            let realm = try await Realm(configuration: flexSyncConfig)
            
            let subscriptions = realm.subscriptions
            
            try await subscriptions.update {
                if let currentSubscription = subscriptions.first(named: "userDriver") {
                    print("Replacing subscription for user_id")
                    currentSubscription.updateQuery(toType: Driver.self)
                } else {
                    print("Appending subscription for user_id")
                    subscriptions.append(QuerySubscription<Driver>(name: "userDriver"))
                }
            }
            print("Successfully opened realm: \(realm)")
            
            self.realm = realm
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
}
