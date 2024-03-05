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
    
    let tripId: ObjectId
    
    init(id: ObjectId) {
        self.tripId = id
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
                            .background(Color(red: 247 / 255, green: 243 / 255, blue: 248 / 255).clipShape(.capsule))
                    }
                    
                    HStack{
                        Image("ic_round_final")
                            .resizable()
                            .frame(width: 16, height: 52)
                        
                        Text(viewModel.trip.dropOff)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                    }
                }
                
                ProgressBar(secondsAlive: 15)
                
                Text("\(viewModel.trip.price) DA")
                    .font(.system(size: 18, weight: .semibold))
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "multiply")
                            .padding(12)
                            .overlay {
                                Circle()
                                    .stroke(Color(red: 237 / 255, green: 234 / 255, blue: 241 / 255), lineWidth: 1)
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button{
                        
                    } label: {
                        Text("Accept")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(red: 99 / 255, green: 22 / 255, blue: 219 / 255))
                            .clipShape(.capsule)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding()
        .background(Color(red: 247 / 255, green: 243 / 255, blue: 248 / 255))
        .fixedSize(horizontal: false, vertical: true)
        .onAppear {
            viewModel.getTripRequest(tripId)
        }
    }
}

#Preview {
    TripRequestSheet(id: .generate())
}
