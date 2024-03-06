//
//  String.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import Foundation

extension String {
    
    var formattedPhone: Self {
        
        let fourthIndex = self.index(self.startIndex, offsetBy: 5)
        
        var formattedNumber = self
            formattedNumber.insert("(", at: self.startIndex)
            formattedNumber.insert(" ", at: fourthIndex)
            formattedNumber.insert(")", at: fourthIndex)
        

            return formattedNumber
        
    }
}
