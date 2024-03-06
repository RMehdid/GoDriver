//
//  Realm.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import Foundation
import RealmSwift

extension Realm {
    mutating func setSubscriptions() async throws {
        
        let subscriptions = self.subscriptions
        
        try await subscriptions.update {
            subscriptions.checkAndSet(subKey: "userDriver", model: Driver.self)
            subscriptions.checkAndSet(subKey: "driverTrip", model: Trip.self)
            subscriptions.checkAndSet(subKey: "driverTripRider", model: Rider.self)
        }
    }
}
