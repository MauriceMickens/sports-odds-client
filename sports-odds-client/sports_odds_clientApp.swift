//
//  sports_odds_clientApp.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI

@main
struct sports_odds_clientApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var authenticationManager = AuthenticationManager()
    @State private var remoteDataLoader = RemoteDataLoader()
    
    var body: some Scene {
        WindowGroup {
            if authenticationManager.isSignedIn {
                MainTabView()
                    .environment(authenticationManager)
                    .environment(remoteDataLoader)
            } else {
                NavigationStack {
                    AuthenticationView(viewModel: .init(authenticationManager: authenticationManager))
                        .environment(authenticationManager)
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
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
