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
        ZStack(alignment: .center){
            VStack(alignment: .leading){
                VStack(spacing: 0){
                    HStack{
                        Image("ic_round_start")
                            .resizable()
                            .frame(width: 16, height: 28)
                        
                        Text(viewModel.trip.pickup)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Text("7 min")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 3.5)
                            .padding(.horizontal, 13)
                    }
                    
                    HStack{
                        Image("ic_round_final")
                            .resizable()
                            .frame(width: 16, height: 28)
                        
                        Text(viewModel.trip.dropOff)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                    }
                }
                
                ProgressBar(secondsAlive: 15)
                    .padding()
                
                Text("\(viewModel.trip.price) DA")
                    .font(.system(size: 18, weight: .semibold))
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "multiply")
                            .overlay {
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                            }
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Accept")
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(red: 99 / 255, green: 22 / 255, blue: 219 / 255))
                            .clipShape(Capsule())
                    }
                }
            }
            .cornerRadius(16)
            .background(Color.white)
        }
        .background(Color(red: 247 / 255, green: 243 / 255, blue: 248 / 255))
    }
}

#Preview {
    TripRequestSheet(id: .generate())
}
