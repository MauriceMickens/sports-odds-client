//
//  Market.swift
//  sports-odds-client
//
//  Created by Mickens on 7/1/24.
//

import Foundation

struct Market: Identifiable, Decodable, Hashable {
    let id = UUID()
    let key: String
    let description: String
}

extension Market: SelectableItem {}


struct PlayerPerformance: Identifiable {
    var id = UUID()
    var game: String
    var points: Double
    var rebounds: Double
    var assists: Double
    var oddsOpening: Double
    var oddsClosing: Double
    var shootingPercentage: Double
    var minutes: Double
    var opponentDefensiveRating: Double // New
    var opponentRanking: Int // New
    var opponentWinLossRecord: String // New
}
