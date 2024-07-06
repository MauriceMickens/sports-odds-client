//
//  MainTabView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    
    @SwiftUI.Environment(AuthenticationManager.self) private var authenticationManager
    @SwiftUI.Environment(RemoteDataLoader.self) private var remoteDataLoader
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            HeaderView(title: "Betlytics")
            
            TabView(selection: $selectedTab) {
                OddsView(viewModel: .init(baseUrl: Environment.local.baseURL, remoteDataLoader: remoteDataLoader))
                    .tabItem {
                        Image(systemName: "house")
                        Text("Betlytics")
                    }
                    .tag(0)
                
                Text("Tab AI")
                    .tabItem {
                        Image(systemName: "message.circle")
                        Text("AI Picks")
                    }
                    .tag(1)
                
                SettingsView(viewModel: .init(authenticationManager: authenticationManager))
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(2)
            }
        }
    }
}

struct HeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    MainTabView()
}
