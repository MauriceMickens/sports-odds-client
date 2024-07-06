//
//  BookmakerCardView.swift
//  sports-odds-client
//
//  Created by Mickens on 7/1/24.
//

import Foundation
import SwiftUI

struct BookmakerCardView: View {
    let bookmaker: Bookmaker
    let selectedMarket: Market
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Bookmaker: \(bookmaker.bookmaker)")
                    .font(.headline)
                Spacer()
                iconForExpectedValue(bookmaker.expectedValue)
            }
            HStack {
                Text("Bet Type: \(bookmaker.betType)")
                    .font(.subheadline)
                Spacer()
                Text("Price: \(bookmaker.price)")
                    .font(.subheadline)
            }
            HStack {
                Text("\(selectedMarket.description): \(bookmaker.point, specifier: "%.2f")")
                    .font(.subheadline)
                Spacer()
                Text("Probability of Win: \(bookmaker.impliedProbability * 100, specifier: "%.0f")%")
                    .font(.subheadline)
            }
            HStack {
                Text("Profit: $\(bookmaker.amountWon, specifier: "%.2f") for every $1 bet")
                    .font(.subheadline)
                Spacer()
                Text("Expected Value: \(bookmaker.expectedValue, specifier: "%.6f")")
                    .font(.subheadline)
                    .foregroundColor(colorForExpectedValue(bookmaker.expectedValue))
            }
            Text("Last Update: \(bookmaker.lastUpdate.formatDate())")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorForExpectedValue(bookmaker.expectedValue), lineWidth: 2)
        )
    }
    
    private func colorForExpectedValue(_ value: Double) -> Color {
        if value > 0 {
            return Color.green
        } else if value == 0 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    private func iconForExpectedValue(_ value: Double) -> some View {
        if value > 0 {
            return Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.green)
        } else if value == 0 {
            return Image(systemName: "hand.raised.fill")
                .foregroundColor(.yellow)
        } else {
            return Image(systemName: "hand.thumbsdown.fill")
                .foregroundColor(.red)
        }
    }
}
