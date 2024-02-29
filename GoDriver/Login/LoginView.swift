//
//  Login.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    var body: some View {
        VStack{
            Spacer()
            
            Button {
                vm.loginAnonymous()
            } label: {
                HStack{
                    Spacer()
                    Text("Sign in Anonymously")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                .background(Color.black)
                .clipShape(Capsule())
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
