//
//  ConsolidatedBookmakerCardViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 7/13/24.
//

import SwiftUI
import Combine

@MainActor @Observable
class BookmakerCardViewModel {
    var bookmakerGroup: BookmakerGroup
    let selectedMarket: Market

    init(bookmakerGroup: BookmakerGroup, selectedMarket: Market) {
        self.bookmakerGroup = bookmakerGroup
        self.selectedMarket = selectedMarket
    }
    
    func betType(_ bookmaker: Bookmaker) -> String {
        "Type: \(bookmaker.betType)"
    }
    
    func odds(_ bookmaker: Bookmaker) -> String {
        "Odds: \(bookmaker.price)"
    }
    
    func probability(_ bookmaker: Bookmaker) -> String {
        String(format: "Win: %.0f%%", bookmaker.impliedProbability * 100)
    }
    
    func profit(_ bookmaker: Bookmaker) -> String {
        String(format: "Profit: $%.2f/1", bookmaker.amountWon)
    }
    
    func expectedValue(_ bookmaker: Bookmaker) -> String{
        String(format: "Exp. Value: %.6f", bookmaker.expectedValue)
    }
    
    func lastUpdated(_ bookmaker: Bookmaker?) -> String {
        guard let lastUpdate = bookmaker?.lastUpdate else {
            return "Last Update: N/A"
        }
        return "Last Update: \(formatDate(lastUpdate))"
    }
    
    private func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.timeStyle = .short
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    func colorForExpectedValue(_ value: Double) -> Color {
        if value > 0 {
            return Color.green
        } else if value == 0 {
            return Color.yellow
        } else {
            return Color.red
        }
    }

    func iconForExpectedValue(_ value: Double) -> some View {
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
