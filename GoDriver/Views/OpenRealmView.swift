import SwiftUI
import RealmSwift

/// Called when login completes. Opens the realm and navigates to the Items screen.
struct OpenRealmView: View {
    @AutoOpen(appId: theAppConfig.appId, timeout: 2000) var autoOpen
    
    @ObservedObject var driver: Driver

    var body: some View {
        switch autoOpen {
        case .connecting:
            ProgressView()
        case .waitingForUser:
            ProgressView("Waiting for user to log in...")
        case .open(let realm):
            HomeView(driver: driver)
        case .progress(let progress):
            ProgressView(progress)
        case .error(let error):
            EmptyView()
        }
    }
}
