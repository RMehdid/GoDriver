//
//  GoDriverApp.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI
import RealmSwift

@main
struct GoDriverApp: SwiftUI.App {
    
    let app: RealmSwift.App? = .init(id: "application-0-wwixx")
    
    var config = Realm.Configuration.defaultConfiguration
    init() {
        config.schemaVersion = 2
    }
    var body: some Scene {
        WindowGroup {
            SyncContentView(app: app!)
        }
    }
}
