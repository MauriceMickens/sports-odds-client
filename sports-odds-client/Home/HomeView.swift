//
//  HomeView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.odds) { odd in
                    let _ = print(odd)
                }
                if !viewModel.odds.isEmpty && viewModel.hasMore {
                    ProgressView("Loading more odds...")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.loadOdds()
                        }
                }
            }
            .task {
                await viewModel.loadOdds()
            }
            .listStyle(.plain)
            .navigationTitle("Odds")
            .overlay {
                if viewModel.isLoading && viewModel.odds.isEmpty {
                    ProgressView("Loading odds...")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    let url = URL(string: "https://example.com/odds")!
    let client = URLSessionHTTPClient()
    let feedLoader = RemoteOddsFeedLoader(client: client)
    let imageLoader = RemoteImageLoader()
    let viewModel = HomeViewModel(baseUrl: url, feedloader: feedLoader, imageLoader: imageLoader)
    
    return HomeView(viewModel: viewModel)
}
