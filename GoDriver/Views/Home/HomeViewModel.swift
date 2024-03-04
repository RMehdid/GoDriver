//
//  HomeViewModel.swift
//  GoDriver
//
//  Created by Samy Mehdid on 1/3/2024.
//

import Foundation
import RealmSwift

extension HomeView {
    class ViewModel: ObservableObject {
        
        let realmManager = RealmManager.shared
        
        private var token: NotificationToken?
        
        @Published var driver: Driver?
        
        func goOnline() {
            self.updateStatus(status: .online)
        }
        
        func goOffline() {
            self.updateStatus(status: .offline)
        }
        
        private func updateStatus(status: DriverStatus) {
            guard let realm = realmManager.realm else {
                return
            }
            
            guard driver?.status == .online || driver?.status == .offline else {
                return
            }
            
            do {
                
                try realm.write {
                    realm.object(ofType: Driver.self, forPrimaryKey: driver?._id)?.status = status
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func getDriver(id: ObjectId) {
            guard let realm = realmManager.realm else {
                return
            }
            
            self.driver = realm.object(ofType: Driver.self, forPrimaryKey: id)
        }
        
        func subscribeToChanges(userId: String) {
            token = driver?.observe { changes in
                switch changes {
                case .change(let object, let properties):
                    // Handle changes to the driver object
                    print("Changed properties: \(properties)")
                    self.objectWillChange.send()
                case .error(let error):
                    // Handle error
                    print("Error: \(error)")
                case .deleted:
                    // Handle deletion
                    print("Driver deleted")
                }
            }
        }
    }
}
