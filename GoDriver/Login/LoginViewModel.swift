//
//  LoginViewModel.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import Foundation
import RealmSwift

extension LoginView {
    class LoginViewModel: ObservableObject {
        
        @Published private(set) var user: User?
        
        func loginAnonymous() {
            let app = App(id: "devicesync-watqv")
            
            app.login(credentials: Credentials.anonymous) { result in
                switch result {
                case .success(let user):
                    self.user = user
                    debugPrint(user.description)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
