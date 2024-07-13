//
//  CardViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Combine
import SwiftUI

@Observable
class CardViewModel {
    @MainActor var playerImage: Image?
    @MainActor var isLoading: Bool = true
    
    private var cancellable: AnyCancellable?
    let odds: Odds
    
    init(odds: Odds) {
        self.odds = odds
        Task { await loadImage() }
    }
    
    var playerName: String {
        odds.player
    }
    
    var homeTeam: String {
        odds.homeTeam
    }
    
    var awayTeam: String {
        odds.awayTeam
    }
    
    var gameDate: String {
        odds.gameDate.formatDate()
    }
    
    var teamPowerRating: String {
        String(format: "Team Power Rating: %.2f", odds.teamPowerRating)
    }
    
    var opponentPowerRating: String {
        String(format: "Opponent Power Rating: %.2f", odds.opponentPowerRating)
    }
    
    var bookmakers: [Bookmaker] {
        odds.bookmakers
    }
    
    @MainActor
    private func loadImage() {
        guard let thumbnailURL = odds.playerImageUrls?.thumbnailURL else {
            self.playerImage = Image(systemName: "person.circle")
            self.isLoading = false
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: thumbnailURL)
            .map { Image(uiImage: UIImage(data: $0.data) ?? UIImage(systemName: "person.circle")!) }
            .catch { _ in Just(Image(systemName: "person.circle")) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.playerImage = image
                self?.isLoading = false
            }
    }
    
    static func formatDate(_ dateString: String) -> String {
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
    
    deinit {
        cancellable?.cancel()
    }
}

extension String {
    
    func formatDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.timeStyle = .short
            return outputFormatter.string(from: date)
        } else {
            return self
        }
    }
}
