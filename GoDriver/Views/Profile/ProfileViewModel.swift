//
//  ProfileViewModel.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import Foundation

extension ProfileView {
    class ViewModel: ObservableObject {
        let driverManager = DriverRepo.sharedDriver
        
        @MainActor
        func updateFullname(_ fullname: String) {
            do {
                try driverManager.updateFullname(fullname)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        func updatePhoneNumber(_ phone: String) {
            do {
                try driverManager.updateFullname(phone)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
