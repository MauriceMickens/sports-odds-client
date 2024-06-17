//
//  sports_odds_clientApp.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import SwiftUI

@main
struct sports_odds_clientApp: App {
    var body: some Scene {
        WindowGroup {
            let client = URLSessionHTTPClient()
            let feedLoader = RemoteOddsFeedLoader(client: client)
            let imageLoader = RemoteImageLoader(client: client)
            let viewModel = HomeViewModel(
                baseUrl: Environment.dev.baseURL,
                feedloader: feedLoader,
                imageLoader: imageLoader
            )
            
            HomeView(viewModel: viewModel)
        }
    }
}

