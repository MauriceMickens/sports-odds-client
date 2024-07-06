//
//  HomeView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import SwiftUI

struct OddsView: View {
    
    @SwiftUI.Environment(RemoteDataLoader.self) private var remoteDataLoader
    @State var viewModel: OddsViewModel
    @State private var selectedOdds: Odds?
    
    init(viewModel: OddsViewModel) {
        self.viewModel = viewModel
    }
    
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
                                .onTapGesture {
                                    selectedOdds = odds
                                }
                                .padding(.horizontal)
                            }
                        case .error(let error):
                            Text(error.reason)
                        case .idle:
                            let _ = print("hi!")
                        }
                    }
                }
            }
            .refreshable {
                do {
                    try await viewModel.refreshData()
                } catch {
                    print(error)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadData()
                } catch {
                    print(error)
                }
            }
        }
        .padding()
        .navigationBarTitle("Betlytics")
        .sheet(item: $selectedOdds) { odds in
            CardDetailView(odds: odds)
        }
    }
}

#Preview {
    return OddsView(viewModel: .mock(count: 6))
}
