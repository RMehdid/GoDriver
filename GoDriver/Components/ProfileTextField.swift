//
//  ProfileTextField.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI

struct ProfileTextFieldStyle: TextFieldStyle {
    
    private let canCopy: Bool
    private let title: String
    
    init(title: String, canCopy: Bool = false) {
        self.title = title
        self.canCopy = canCopy
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 14, weight: .semibold))
            
            HStack{
                configuration
                
                Spacer()
                
                if canCopy {
                    Button {
                        // implement copy here
                        
                    } label: {
                        Image("ic_copy")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(14)
            .background(Color(red: 237/255, green: 234/255, blue: 241/255).cornerRadius(8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 217/255, green: 213/255, blue: 226/255), lineWidth: 2)
            )
        }
    }
}

#Preview {
    
    TextField("", text: .constant("1838820"))
        .textFieldStyle(ProfileTextFieldStyle(title: "ID", canCopy: true))
        .padding()
}
