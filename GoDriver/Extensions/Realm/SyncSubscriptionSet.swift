//
//  SyncSubscriptionSet.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import Foundation
import RealmSwift
import Realm

extension SyncSubscriptionSet {
    func checkAndSet<Model: Object>(subKey: String, model: Model.Type) {
        if let selfSub = self.first(named: subKey) {
            print("Replacing subscription for \(subKey)")
            selfSub.updateQuery(toType: Model.self)
        } else {
            print("Appending subscription for \(subKey)")
            self.append(QuerySubscription<Model>(name: subKey))
        }
    }
}
