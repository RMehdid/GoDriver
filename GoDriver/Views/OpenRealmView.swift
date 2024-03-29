import SwiftUI
import RealmSwift

/// Called when login completes. Opens the realm and navigates to the Items screen.
struct OpenRealmView: View {
    @AutoOpen(appId: app.appId, timeout: 2000) var autoOpen
    
    @ObservedObject var driver: Driver
    
    let realmManager = RealmManager.shared

    var body: some View {
        switch autoOpen {
        case .connecting:
            ProgressView()
        case .waitingForUser:
            ProgressView("Waiting for user to log in...")
        case .open(let realm):
            if let currentTripId = driver.currentTripId {
                TripFlowView(id: currentTripId)
            } else {
                HomeView(driver: driver)
            }
            
        case .progress(let progress):
            SplashView(progress: progress)
        case .error(let error):
            EmptyView()
        }
    }
}
