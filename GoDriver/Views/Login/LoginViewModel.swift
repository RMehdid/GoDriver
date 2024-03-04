//
//  LoginViewModel.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation

extension LoginView {
    class ViewModel: ObservableObject {
        private let realmManager = RealmManager.shared
        
        @Published private(set) var loginUiState: LoginInUiState = .loggedOut
        
        /// Logs in with an existing user.
        @MainActor
        func login(email: String, password: String) {
            loginUiState = .logginIn
            Task {
                do {
                    try await realmManager.login(email: email, password: password)
                    loginUiState = .loggedIn
                } catch {
                    loginUiState = .loggedOut
                }
            }
        }
        
        /// Registers a new user with the email/password authentication provider.
        @MainActor
        func signUp(email: String, password: String) {
            self.loginUiState = .logginIn
            Task {
                do {
                    try await realmManager.signUp(email: email, password: password)
                    self.loginUiState = .loggedIn
                } catch {
                    self.loginUiState = .loggedOut
                }
            }
        }
    }
}
