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
        VStack {
            HorizontalScrollRow(
                selectedItem: $viewModel.selectedSport,
                items: viewModel.activeSports
            )
            
            HorizontalScrollRow(
                selectedItem: $viewModel.selectedMarket,
                items: viewModel.activeMarkets
            )
            
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                        case .loaded:
                            ForEach(viewModel.filteredObjects) { odds in
                                CardView(
                                    viewModel: .init(odds: odds),
                                    selectedMarket: viewModel.selectedMarket
                                )
                                .padding(.horizontal)
                            }
                        case .error(let error):
                            Text(error.reason)
                        }
                    }
                }
            }
        }
        .task {
            do {
                try await viewModel.loadData()
            } catch {
                print(error)
            }
        }
        .padding()
        .navigationBarTitle("Betlytics")
    }
}

#Preview {
    return HomeView(viewModel: .mock(count: 6))
}
