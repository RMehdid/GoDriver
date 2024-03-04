//
//  Driver.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

class Driver: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: String
    
    @Persisted var fullname: String
    @Persisted var tripRequestId: ObjectId?
    @Persisted var currentTripId: ObjectId?
    @Persisted var isOnline: Bool
    @Persisted var revenue: Int
    @Persisted var profileImageUrl: String?
    
    convenience init(id: String, fullname: String) {
        self.init()
        self._id = id
        self.fullname = fullname
        self.tripRequestId = .generate()
        self.currentTripId = nil
        self.isOnline = false
        self.revenue = 0
    }
}
