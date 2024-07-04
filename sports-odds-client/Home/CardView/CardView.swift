//
//  CardView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/23/24.
//

import SwiftUI

struct CardView: View {
    @StateObject private var viewModel: CardViewModel
    private let selectedMarket: Market
    
    init(selectedMarket: Market, odds: Odds) {
        _viewModel = StateObject(wrappedValue: CardViewModel(odds: odds))
        self.selectedMarket = selectedMarket
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: 100, height: 100)
                } else {
                    viewModel.playerImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.playerName)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(viewModel.homeTeam)
                        .font(.subheadline)
                    Text("vs")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.awayTeam)
                        .font(.subheadline)
                    Text(viewModel.gameDate)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.bookmakers) { bookmaker in
                    BookmakerCardView(
                        bookmaker: bookmaker,
                        selectedMarket: selectedMarket
                    )
                    .padding(.vertical, 5)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    CardView(
        selectedMarket: .init(key: "points", description: "Points"), 
        odds: Odds.random
    )
        .padding()
        .background(Color.black)
}
