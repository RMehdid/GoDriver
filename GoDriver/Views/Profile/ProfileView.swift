//
//  ProfileView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI
import RealmSwift

struct ProfileView: View {
    
    @ObservedRealmObject var driver: Driver
    @StateObject private var viewModel = ViewModel()
    
    @State private var id: String = ""
    @State private var fullname: String = ""
    @State private var phoneNumber: String = ""
    
    init(driver: Driver) {
        self._driver = ObservedRealmObject(wrappedValue: driver)
        
        self._id = State(initialValue: driver._id)
        self._fullname = State(initialValue: driver.fullname)
        self._phoneNumber = State(initialValue: driver.phoneNumber)
    }
    
    var body: some View {
        VStack {
            Spacer()
                
            VStack(spacing: 16){
                
                TextField("ID", text: $id)
                    .textFieldStyle(ProfileTextFieldStyle(title: "ID", canCopy: true))
                    .disabled(true)
                
                TextField("Fullname", text: $fullname)
                    .textFieldStyle(ProfileTextFieldStyle(title: "Fullname"))
                
                TextField("Phone number", text: $phoneNumber)
                    .textFieldStyle(ProfileTextFieldStyle(title: "Phone number"))
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding()
            .frame(height: UIScreen.main.bounds.height / 1.5)
            .background(Color.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20
                )
            )
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .background(Color.yaDarkPurple)
        .onChange(of: fullname) { _, newValue in
            viewModel.updateFullname(newValue)
        }
        .onChange(of: driver.fullname) { _, newValue in
            fullname = newValue
        }
        .onChange(of: phoneNumber) { _, newValue in
            viewModel.updatePhoneNumber(newValue)
        }
        .onChange(of: driver.phoneNumber) { _, newValue in
            phoneNumber = newValue
        }
    }
}

#Preview {
    ProfileView(driver: Driver(id: "10202", fullname: "Samy H"))
}
