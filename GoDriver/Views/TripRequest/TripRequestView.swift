//
//  TripRequestView.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import SwiftUI
import RealmSwift

struct TripRequestSheet: View {
    
    @StateObject private var viewModel = ViewModel()
    
    init(id: ObjectId) {
        viewModel.getTripRequest(id)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TripRequestSheet(id: .generate())
}
