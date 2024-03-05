//
//  ProfileViewModel.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import Foundation

extension ProfileView {
    class ViewModel: ObservableObject {
        let realmManager = RealmManager.shared
        
        @MainActor
        func updateFullname(_ fullname: String) {
            do {
                try realmManager.realm?.write {
                    realmManager.driver?.fullname = fullname
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        func updatePhoneNumber(_ phone: String) {
            do {
                try realmManager.realm?.write {
                    realmManager.driver?.phoneNumber = phone
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
