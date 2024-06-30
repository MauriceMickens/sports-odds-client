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
            GridItem(.flexible(minimum: 100, maximum: 160)),
            GridItem(.flexible(minimum: 150, maximum: 160))
        ]
    }
    
    var body: some View {
        VStack {
            SportsScrollRow(sports: viewModel.activeSports)
                .padding(.horizontal)
            
            MarketsScrollRow(viewModel: viewModel)
            
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 15) {
                    Group {
                        switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                        case .loaded(let objects):
                            ForEach(objects) { odds in
                                CardView(odds: odds)
                                    .aspectRatio(0.67, contentMode: .fit)
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
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.activeMarkets) { market in
                    Button(action: {
                        viewModel.filterOdds(for: market.key)
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
