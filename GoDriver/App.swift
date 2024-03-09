import SwiftUI
import RealmSwift
import BackgroundTasks

@main
struct GoDriverApp: SwiftUI.App {
    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Logger.shared.level = .trace
                }
        }
        .onChange(of: phase, perform: BackgroundManager.shared.launchAppRefresh)
        .backgroundTask(.appRefresh("background_refresh")) {
            await RealmManager.shared.initialize()
        }
    }
}
