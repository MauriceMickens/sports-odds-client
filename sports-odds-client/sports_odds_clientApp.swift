//
//  sports_odds_clientApp.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import SwiftUI

@main
struct sports_odds_clientApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(appState)
        }
    }
}

