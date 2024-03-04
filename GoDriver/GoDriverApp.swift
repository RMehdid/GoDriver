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
    
    @StateObject private var realmManager = RealmManager.shared

    var body: some Scene {
        WindowGroup {
            VStack{
                if let realm = realmManager.realm,
                   let driver = realmManager.driver {
                    HomeView(driver: driver)
                        .environment(\.realmConfiguration, realm.configuration)
                        .environment(\.realm, realm)
                }
            }.task {
                try? await realmManager.initialize()
            }
        }
    }
}
