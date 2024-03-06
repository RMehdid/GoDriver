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
        ZStack{
            if let trip = viewModel.trip {
                ZStack(alignment: .center){
                    VStack(alignment: .leading){
                        VStack(spacing: 0){
                            HStack{
                                Image("ic_round_start")
                                    .resizable()
                                    .frame(width: 16, height: 28)
                                
                                
                                Text(trip.pickup)
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
                                
                                
                                Text(trip.dropOff)
                                    .font(.system(size: 14, weight: .semibold))
                                Spacer()
                            }
                        }
                        
                        ProgressBar(secondsAlive: 15)
                        
                        Text("\(trip.price) DA")
                            .font(.system(size: 18, weight: .semibold))
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                viewModel.rejectTrip(tripId: tripId)
                            } label: {
                                Image(systemName: "multiply")
                                    .padding(12)
                                    .overlay {
                                        Circle()
                                            .stroke(Color(red: 237 / 255, green: 234 / 255, blue: 241 / 255), lineWidth: 1)
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            
                            NavigationLink {
                                TripFlowView(trip: trip)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                Text("Accept")
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                    .background(Color(red: 99 / 255, green: 22 / 255, blue: 219 / 255))
                                    .clipShape(.capsule)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                viewModel.acceptTrip(tripId: tripId)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
                .padding()
                .background(Color(red: 247 / 255, green: 243 / 255, blue: 248 / 255))
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .onAppear {
            viewModel.getTripRequest(tripId)
        }
            
    }
}

#Preview {
    TripRequestSheet(id: .generate())
}
