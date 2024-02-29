//
//  DriverStatus.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import Foundation
import RealmSwift

enum DriverStatus: String, PersistableEnum {
    case online
    case offline
    case onTrip
    case onRequest
}
