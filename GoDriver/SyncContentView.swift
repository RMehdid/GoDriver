//
//  SyncContentView.swift
//  GoDriver
//
//  Created by Samy Mehdid on 29/2/2024.
//

import SwiftUI
import RealmSwift

struct SyncContentView: View {
    
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            ContentView()
        } else {
            ProgressView()
                .task {
                    do {
                        let myUser = try await app.login(credentials: .anonymous)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}

#Preview {
    SyncContentView(app: RealmSwift.App(id: ""))
}
