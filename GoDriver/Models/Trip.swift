//
//  Trip.swift
//  GoDriver
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

class Trip: Object, ObjectKeyIdentifiable {
    
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
    }
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
