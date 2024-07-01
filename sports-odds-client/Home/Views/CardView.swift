//
//  CardView.swift
//  sports-odds-client
//
//  Created by Mickens on 6/23/24.
//

import SwiftUI

struct CardView: View {
    @StateObject var viewModel: CardViewModel
    
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
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Bookmaker: \(bookmaker.bookmaker)")
                            .font(.headline)
                        HStack {
                            Text("Bet Type: \(bookmaker.betType)")
                                .font(.subheadline)
                            Spacer()
                            Text("Price: \(bookmaker.price)")
                                .font(.subheadline)
                        }
                        HStack {
                            Text("Point: \(bookmaker.point, specifier: "%.2f")")
                                .font(.subheadline)
                            Spacer()
                            Text("Implied Probability: \(bookmaker.impliedProbability, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        HStack {
                            Text("Amount Won: \(bookmaker.amountWon, specifier: "%.2f")")
                                .font(.subheadline)
                            Spacer()
                            Text("Expected Value: \(bookmaker.expectedValue, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Text("Last Update: \(bookmaker.lastUpdate)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
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
    CardView(viewModel: CardViewModel(odds: Odds.random))
        .padding()
        .background(Color.black)
}


