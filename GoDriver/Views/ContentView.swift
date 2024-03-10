import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject private var realmManager = RealmManager.shared
    @StateObject private var driverManager = DriverRepo.sharedDriver

    var body: some View {
        if let _ = app.currentUser {
            ZStack{
                if let driver = driverManager.driver,
                   nil != realmManager.realm {
                    OpenRealmView(driver: driver)
                } else {
                    SplashView(progress: .discreteProgress(totalUnitCount: 100))
                }
            }
            .task { await realmManager.initialize() }
            .task {
                do {
                    try await driverManager.getDriver()
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
            
        } else {
            LoginView()
        }
    }
}
