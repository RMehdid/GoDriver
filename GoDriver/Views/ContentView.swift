import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject private var realmManager = RealmManager.shared

    var body: some View {
        if let _ = app.currentUser {
            ZStack{
                if let driver = realmManager.driver,
                   nil != realmManager.realm {
                    OpenRealmView(driver: driver)
                }
            }
            .task{ await realmManager.initialize() }
        } else {
            LoginView()
        }
    }
}
