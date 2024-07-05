//
//  sports_odds_clientApp.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Firebase
import FirebaseCore
import SwiftUI

@main
struct sports_odds_clientApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appState = AppState(authenticationManager: AuthenticationManager())
    
    var body: some Scene {
        WindowGroup {
            if appState.isSignedIn {
                MainTabView()
                    .environmentObject(appState)
            } else {
                NavigationStack {
                    AuthenticationView()
                        .environmentObject(appState)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
