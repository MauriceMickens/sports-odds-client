//
//  HomeView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var gridColumns: [GridItem] {
        [
            GridItem(.flexible(minimum: 150, maximum: 160)),
            GridItem(.flexible(minimum: 150, maximum: 160))
        ]
    }
    
    var body: some View {
        VStack {
            SportsScrollRow(sports: viewModel.activeSports)
                .padding(.horizontal)
            
            MarketsScrollRow(
                selectedMarket: $viewModel.selectedMarket,
                activeMarkets: $viewModel.activeMarkets
            )
            
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 15) {
                    Group {
                        switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                        case .loaded:
                            ForEach(viewModel.filteredObjects) { odds in
                                CardView(viewModel: .init(odds: odds))
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

struct SportsScrollRow: View {
    let sports: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(sports, id: \.self) { sport in
                    Text(sport)
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .frame(width: 60, height: 60)
                        .background(.red)
                }
            }
        }
    }
}

struct MarketsScrollRow: View {
    @Binding var selectedMarket: String
    @Binding var activeMarkets: [Market]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(activeMarkets) { market in
                    Button(action: {
                        selectedMarket = market.key
                    }) {
                        Text(market.description)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .frame(width: 80, height: 30)
                            .background(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    return HomeView(viewModel: .mock(count: 6))
}
