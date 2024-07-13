//
//  TechnicalAnalysisViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

class TechnicalAnalysisViewModel: ObservableObject {
    @Published var playerPerformances: [PlayerPerformance] = []
    @Published var leagueAverages: PlayerPerformance?
    @Published var similarPlayers: [PlayerPerformance] = []
    
    init() {
        // Load mock data
        loadMockData()
    }
    
    func loadMockData() {
        self.playerPerformances = [
            PlayerPerformance(game: "Game 1", points: 20, rebounds: 5, assists: 7, oddsOpening: 150, oddsClosing: 130, shootingPercentage: 45.0, minutes: 30.0, opponentDefensiveRating: 105.0, opponentRanking: 5, opponentWinLossRecord: "25-15"),
            PlayerPerformance(game: "Game 2", points: 15, rebounds: 8, assists: 5, oddsOpening: 140, oddsClosing: 125, shootingPercentage: 50.0, minutes: 28.0, opponentDefensiveRating: 110.0, opponentRanking: 8, opponentWinLossRecord: "20-20"),
            PlayerPerformance(game: "Game 3", points: 18, rebounds: 6, assists: 6, oddsOpening: 160, oddsClosing: 135, shootingPercentage: 47.0, minutes: 32.0, opponentDefensiveRating: 100.0, opponentRanking: 3, opponentWinLossRecord: "30-10")
        ]
        
        self.leagueAverages = PlayerPerformance(game: "League Average", points: 17.5, rebounds: 7.5, assists: 6.5, oddsOpening: 0, oddsClosing: 0, shootingPercentage: 48.0, minutes: 32.0, opponentDefensiveRating: 0, opponentRanking: 0, opponentWinLossRecord: "")
        
        self.similarPlayers = [
            PlayerPerformance(game: "Player 1", points: 18.0, rebounds: 7.0, assists: 6.0, oddsOpening: 0, oddsClosing: 0, shootingPercentage: 46.0, minutes: 31.0, opponentDefensiveRating: 0, opponentRanking: 0, opponentWinLossRecord: ""),
            PlayerPerformance(game: "Player 2", points: 19.0, rebounds: 7.5, assists: 6.2, oddsOpening: 0, oddsClosing: 0, shootingPercentage: 49.0, minutes: 33.0, opponentDefensiveRating: 0, opponentRanking: 0, opponentWinLossRecord: "")
        ]
    }
    
    func getRollingAverageData(for period: Int) -> [Double] {
        let points = playerPerformances.map { $0.points }
        return points.movingAverage(period: period)
    }
    
    func getRollingAverage(for period: Int, type: RollingAverageType) -> Double {
        let data: [Double]
        switch type {
        case .points:
            data = playerPerformances.map { $0.points }
        case .shootingPercentage:
            data = playerPerformances.map { $0.shootingPercentage }
        case .minutes:
            data = playerPerformances.map { $0.minutes }
        }
        return data.movingAverage(period: period).last ?? 0.0
    }
}

enum StatType {
    case points, shootingPercentage, minutes
}

enum RollingAverageType {
    case points
    case shootingPercentage
    case minutes
}

extension Array where Element == Double {
    func average() -> Double {
        guard !isEmpty else { return 0.0 }
        let total = reduce(0, +)
        return total / Double(count)
    }
    
    func movingAverage(period: Int) -> [Double] {
        var result = [Double]()
        for i in 0..<count {
            let start = Swift.max(i - period + 1, 0)
            let end = i
            let slice = Array(self[start...end])
            result.append(slice.average())
        }
        return result
    }
}
