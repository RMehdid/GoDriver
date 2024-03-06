//
//  Date.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
