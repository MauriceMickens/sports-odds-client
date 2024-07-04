//
//  MainTabView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @State var viewModelFactory = ViewModelFactory()
    @State private var selectedTab = 0
    
    var body: some View {
        HeaderView(title: "Betlytics")
        
        TabView(selection: $selectedTab) {
            OddsView(viewModel: viewModelFactory.makeOddsViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Betlytics")
                }
                .tag(0)
            
            Text("Tab 1")
                .tabItem {
                    Image(systemName: "message.circle")
                    Text("AI Picks")
                }
                .tag(1)
            
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
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
