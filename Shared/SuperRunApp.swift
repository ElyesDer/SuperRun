//
//  SuperRunApp.swift
//  Shared
//
//  Created by DerouicheElyes on 22/5/2021.
//

import SwiftUI

@main
struct SuperRunApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
