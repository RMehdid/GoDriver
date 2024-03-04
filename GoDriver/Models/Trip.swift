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
    
    @Persisted var status: TripStatus
    
    @Persisted var price: Int
    
    @Persisted var pickup: String
    
    @Persisted var dropOff: String
    
    @Persisted var rider: Rider
    
    convenience init(id: ObjectId) {
        self.init()
        self._id = id
    }
}

enum TripStatus: String, PersistableEnum {
    case pending
    case accepted
    case toClient
    case arrivedClient
    case toDestination
    case arrivedDestination
}
