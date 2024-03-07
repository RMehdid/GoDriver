//
//  TripFlowView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 5/3/2024.
//

import SwiftUI
import MapKit
import RealmSwift

struct TripFlowView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    let tripId: ObjectId
    
    init(id: ObjectId) {
        self.tripId = id
    }
    
    var buttonTitle: String {
        switch viewModel.trip?.status {
        case .accepted:
            return "Go to client"
        case .toClient:
            return "Notify your arrival"
        case .arrivedClient:
            return "Start Trip"
        case .toDestination:
            return "Finish Ride"
        default: return ""
        }
    }
    
    var body: some View {
        ZStack {
            Map(initialPosition: .automatic)
            
            VStack {
                if let trip = viewModel.trip {
                    TripInfoCard(trip: trip)
                        .padding()
                }
                
                Spacer()
                
                VStack(spacing: 24){
                    if let rider = viewModel.trip?.rider.first {
                        HStack {
                            Circle()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading){
                                
                                Text(rider.fullname)
                                    .font(.system(size: 17, weight: .bold))
                                
                                HStack {
                                    Image("ic_star")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                    
                                    Text(rider.rating.nicer())
                                        .font(.system(size: 14, weight: .regular))
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                guard let phoneURL = URL(string: "tel://\(rider.phoneNumber)"),
                                      UIApplication.shared.canOpenURL(phoneURL) else { return }
                                
                                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                            } label: {
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .padding(15)
                                    .background(Color.green)
                                    .clipShape(.circle)
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    
                    Button {
                        viewModel.updateTripStatus()
                    } label: {
                        Text(buttonTitle)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.yaPurple)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .padding()
                .padding(.bottom, 32)
                .background(Color.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 16,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 16
                    )
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                viewModel.getTrip(tripId)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TripFlowView(id: ObjectId("65e8373bdd4e088a23176b9d"))
}
