//
//  BackgroundManager.swift
//  GoDriver
//
//  Created by Samy Mehdid on 9/3/2024.
//

import Foundation
import SwiftUI
import BackgroundTasks

class BackgroundManager {
    
    static let shared = BackgroundManager()
    
    init() {
        
    }
    
    func launchAppRefresh(_ newPhase: ScenePhase) -> Void {
        switch newPhase {
        case .background: scheduleAppRefresh()
        default: break
        }
    }
    
    private func scheduleAppRefresh() {
        let backgroundTask = BGAppRefreshTaskRequest(identifier: "background_refresh")
        backgroundTask.earliestBeginDate = .now.addingTimeInterval(10)
        try? BGTaskScheduler.shared.submit(backgroundTask)
        print("Successfully scheduled a background task")
    }
}
