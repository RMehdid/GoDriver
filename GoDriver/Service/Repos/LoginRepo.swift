//
//  LoginRepo.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation

class LoginRepo: RealmManager {
    
    static let sharedLogin = LoginRepo()
    
    @MainActor
    func login(email: String, password: String) async throws {
        let _ = try await app.login(credentials: .emailPassword(email: email, password: password))
    }
    
    @MainActor
    func signUp(email: String, password: String) async throws {
        try await app.emailPasswordAuth.registerUser(email: email, password: password)
        try await self.login(email: email, password: password)
        try await DriverRepo.sharedDriver.createDriver()
    }
}
