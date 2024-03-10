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
            .task { 
               await runTasks()
            }
            
        } else {
            LoginView()
        }
    }
    
    private func runTasks() async {
        await realmManager.initialize()
        await driverManager.getDriver()
    }
}
