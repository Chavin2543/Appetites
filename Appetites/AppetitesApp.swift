//
//  AppetitesApp.swift
//  Appetites
//
//  Created by chavin Panicharoen on 29/1/2565 BE.
//

import SwiftUI

@main
struct AppetitesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
