//
//  Rider.swift
//  GoDriver
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

class Rider: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: String
    
    @Persisted var fullname: String
    
    @Persisted var profileImageUrl: String?
    
    @Persisted var phoneNumber: String
    
    @Persisted var rating: Double
    
    @Persisted var trips: List<Trip>
    
    convenience init(_id: String) {
        self.init()
        self._id = _id
        self.fullname = "Samy Abderraouf Mehdid"
        self.profileImageUrl = nil
        self.phoneNumber = "+213540408051"
        self.rating = 5.0
    }
}
