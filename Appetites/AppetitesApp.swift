//
//  AppetitesApp.swift
//  Appetites
//
//  Created by chavin Panicharoen on 29/1/2565 BE.
//

import SwiftUI

@main
struct AppetitesApp: App {
    
    @StateObject private var userService:UserDataService = UserDataService()

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(userService)
        }
    }
}
