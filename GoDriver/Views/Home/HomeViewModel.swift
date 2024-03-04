//
//  HomeViewModel.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

extension HomeView {
    class ViewModel: ObservableObject {
        
        let realmManager = RealmManager.shared
        
        @MainActor
        func updateDriverOnline(isOnline: Bool) {
            do {
                try realmManager.realm?.write {
                    realmManager.driver?.isOnline = isOnline
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
