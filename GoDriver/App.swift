import SwiftUI
import RealmSwift

/// This method loads app config details from a atlasConfig.plist we generate
/// for the template apps.
/// When you create your own Atlas Device Sync app, use your preferred method
/// to store and access app configuration details.
let theAppConfig = loadAppConfig()

let atlasUrl = theAppConfig.atlasUrl

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil))

@main
struct GoDriverApp: SwiftUI.App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Logger.shared.level = .debug
                }
        }
    }
}
