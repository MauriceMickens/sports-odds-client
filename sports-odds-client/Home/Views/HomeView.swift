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
            SportsScrollRow(
                selectedSport: $viewModel.selectedSport,
                activeSports: $viewModel.activeSports
            )

            MarketsScrollRow(
                selectedMarket: $viewModel.selectedMarket,
                activeMarkets: $viewModel.activeMarkets
            )
            
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                        case .loaded:
                            ForEach(viewModel.filteredObjects) { odds in
                                CardView(viewModel: .init(odds: odds))
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

struct SportsScrollRow: View {
    @Binding var selectedSport: String
    @Binding var activeSports: [Sport]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(activeSports) { sport in
                    Button {
                        selectedSport = sport.key
                    } label: {
                        Text(sport.description)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .frame(width: 100, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            )
                    }
                }
            }
            .padding(.horizontal)
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
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    return HomeView(viewModel: .mock(count: 6))
}
