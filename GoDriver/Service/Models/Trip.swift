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
}

extension Trip {
    enum Status: String, PersistableEnum {
        case canceled
        case pending
        case accepted
        case toClient
        case arrivedClient
        case toDestination
        case arrivedDestination
        case completed
        
        var next: Self {
            switch self {
            case .canceled:
                return .accepted
            case .pending:
                return .accepted
            case .accepted:
                return .toClient
            case .toClient:
                return .arrivedClient
            case .arrivedClient:
                return .toDestination
            case .toDestination:
                return .arrivedDestination
            case .arrivedDestination:
                return .completed
            case .completed:
                return .completed
            }
        }
        
        mutating func setNext() {
            self = self.next
        }
    }
}

extension Trip {
    enum Category: String, PersistableEnum {
        case classic
        case business
    }
}

extension List where Element == Trip {
    var groupedByDate: [String: [Trip]] {
        var tripsByDate: [String: [Trip]] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy"
        
        let today = Calendar.current.startOfDay(for: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        
        for trip in self {
            let tripDate = Calendar.current.startOfDay(for: trip.updatedAt)
            var dateString = ""
            
            if tripDate == today {
                dateString = "Today"
            } else if tripDate == yesterday {
                dateString = "Yesterday"
            } else {
                dateString = dateFormatter.string(from: trip.updatedAt)
            }
            
            if var tripsOnDate = tripsByDate[dateString] {
                tripsOnDate.append(trip)
                tripsByDate[dateString] = tripsOnDate
            } else {
                tripsByDate[dateString] = [trip]
            }
        }
        
        return tripsByDate
    }
}
