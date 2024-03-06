//
//  Double.swift
//  GoDriver
//
//  Created by Samy Mehdid on 6/3/2024.
//

import Foundation

public extension Double {
    func nicer(_ round: Int = 2) -> String {
        if self > Double(Int(self)) {
            return String(format: "%.\(round)f", self)
        } else {
            return String(format: "%.0f", self)
        }
    }
}
