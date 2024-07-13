//
//  CardView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/23/24.
//

import SwiftUI

struct CardView: View {
    @State var viewModel: CardViewModel
    private let selectedMarket: Market
    
    init(viewModel: CardViewModel, selectedMarket: Market) {
        self.viewModel = viewModel
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
            
            HStack {
                powerRatingView(
                    label: "Power Rating",
                    rating: viewModel.odds.teamPowerRating,
                    isSwitch: true
                )
                powerRatingView(
                    label: "Power Rating",
                    rating: viewModel.odds.opponentPowerRating,
                    isSwitch: false
                )
            }
            .padding(.vertical, 5)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.bookmakers.groupedBookmakerGroups(by: { $0.bookmaker })) { groupedBookmaker in
                    BookmakerCardView(
                        viewModel: .init(
                            bookmakerGroup: groupedBookmaker,
                            selectedMarket: selectedMarket
                        )
                    )
                }
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    private func powerRatingView(label: String, rating: Double, isSwitch: Bool) -> some View {
        HStack {
            Image(systemName: isSwitch ? "house.fill" : "person.fill")
                .foregroundColor(.white)
                .padding(6)
                .background(isSwitch ? Color.green : Color.red)
                .clipShape(Circle())
            Text("\(label): \(rating, specifier: "%.2f")")
                .font(.subheadline)
                .padding(6)
                .background(isSwitch ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .cornerRadius(10)
        }
        .padding(.horizontal, 10)
    }
}
