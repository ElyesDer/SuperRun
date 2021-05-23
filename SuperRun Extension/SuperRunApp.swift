//
//  SuperRunApp.swift
//  SuperRun Extension
//
//  Created by DerouicheElyes on 23/5/2021.
//

import SwiftUI

@main
struct SuperRunApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
