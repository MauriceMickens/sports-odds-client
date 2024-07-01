//
//  CardViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Combine
import SwiftUI

class CardViewModel: ObservableObject {
    @Published var playerImage: Image?
    @Published var isLoading: Bool = true
    
    private var cancellable: AnyCancellable?
    private let odds: Odds
    
    init(odds: Odds) {
        self.odds = odds
        loadImage()
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
        formatDate(odds.gameDate)
    }
    
    var bookmakers: [Bookmaker] {
        odds.bookmakers
    }
    
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
    
    private func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
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
