import SwiftUI
import RealmSwift
import BackgroundTasks

/// This method loads app config details from a atlasConfig.plist we generate
/// for the template apps.
/// When you create your own Atlas Device Sync app, use your preferred method
/// to store and access app configuration details.
let theAppConfig = loadAppConfig()

let atlasUrl = theAppConfig.atlasUrl

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil))

@main
struct GoDriverApp: SwiftUI.App {

    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Logger.shared.level = .debug
                }
        }
        .onChange(of: phase) { _, newPhase in
            switch newPhase {
            case .background: scheduleAppRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("background_refresh")) {
            await RealmManager.shared.initialize()
        }
    }
    
    private func scheduleAppRefresh() {
        let backgroundTask = BGAppRefreshTaskRequest(identifier: "background_refresh")
        backgroundTask.earliestBeginDate = .now.addingTimeInterval(10)
        try? BGTaskScheduler.shared.submit(backgroundTask)
        print("Successfully scheduled a background task")
        
      }
}
