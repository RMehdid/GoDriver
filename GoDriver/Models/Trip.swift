//
//  Trip.swift
//  GoDriver
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift
import Realm

class Trip: RealmSwiftObject, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var status: Trip.Status
    
    @Persisted var price: Int
    
    @Persisted var pickup: String
    
    @Persisted var dropOff: String
    
    @Persisted var category: Trip.Category
    
    @Persisted var createdAt: Date
    
    @Persisted var updatedAt: Date
    
    @Persisted(originProperty: "trips") var rider: LinkingObjects<Rider>
    
    @Persisted(originProperty: "trips") var driver: LinkingObjects<Driver>
    
    convenience init(id: ObjectId) {
        self.init()
        self._id = id
        self.status = .pending
        self.price = 450
        self.pickup = "Said Hamdine"
        self.dropOff = "Bab El Oued"
        self.category = .business
        self.createdAt = .now
        self.updatedAt = .now
    }
    
//    convenience override init() {
//        self.init()
//        self._id = .generate()
//        self.status = .pending
//        self.price = 450
//        self.pickup = "Said Hamdine"
//        self.dropOff = "Bab El Oued"
//        self.category = .business
//        self.createdAt = .now
//        self.updatedAt = .now
//    }
}

extension Trip {
    enum Status: String, PersistableEnum {
        case pending
        case accepted
        case toClient
        case arrivedClient
        case toDestination
        case arrivedDestination
    }
}

extension Trip {
    enum Category: String, PersistableEnum {
        case classic = "Classic"
        case business = "Business"
    }
}
