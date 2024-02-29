//
//  Driver.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import Foundation
import RealmSwift

class Driver: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var fullname: String
    @Persisted var tripRequestId: Int?
    @Persisted var currentTripId: Int?
    @Persisted var status: DriverStatus
    @Persisted var revenue: Int
}
