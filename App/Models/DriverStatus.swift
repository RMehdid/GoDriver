//
//  DriverStatus.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

enum DriverStatus: String, PersistableEnum {
    case online
    case offline
    case onTrip
    case onRequest
}
