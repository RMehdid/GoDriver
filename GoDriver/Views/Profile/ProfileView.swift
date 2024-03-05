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
    
    init(driver: Driver) {
        self._driver = ObservedRealmObject(wrappedValue: driver)
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            ZStack{
                VStack {
                    VStack{
                        Text(driver.fullname)
                            .font(.system(size: 18, weight: .semibold))
                        Text(driver.phoneNumber.formattedPhone)
                    }
                    
                    
                }
            }
            .background(Color.white)
        }
        .background(Color.yaDarkPurple)
    }
}

#Preview {
    ProfileView(driver: Driver(id: "10202", fullname: "Samy H"))
}
