//
//  Driver.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import Foundation
import RealmSwift

class Driver: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    
    @Persisted var fullname: String
    @Persisted var tripRequestId: ObjectId?
    @Persisted var currentTripId: ObjectId?
    @Persisted var status: DriverStatus
    @Persisted var revenue: Int
    
    var isOnline: Bool {
        return status != .offline
    }
}
