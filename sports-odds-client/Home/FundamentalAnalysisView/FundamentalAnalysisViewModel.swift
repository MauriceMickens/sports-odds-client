//
//  FundamentalAnalysisViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 7/11/24.
//

import SwiftUI

class FundamentalAnalysisViewModel: ObservableObject {
    @Published var playerFactors: [PlayerFactor] = []
    @Published var teamFactors: [TeamFactor] = []
    @Published var matchupFactors: [MatchupFactor] = []
    @Published var scenarioFactors: [ScenarioFactor] = []
    @Published var externalFactors: [ExternalFactor] = []
    @Published var performanceVariance: [PerformanceVariance] = []
    
    // Load mock data or fetch from API
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        // Example data
        self.playerFactors = [
            PlayerFactor(title: "Health Status", detail: "Player is fully healthy"),
            PlayerFactor(title: "Recent Performance", detail: "Averaging 25 points over the last 5 games")
        ]
        
        self.teamFactors = [
            TeamFactor(title: "Overall Team Talent", detail: "Team has an average rating of 85"),
            TeamFactor(title: "Recent Team Performance", detail: "Team has won 4 out of the last 5 games")
        ]
        
        self.matchupFactors = [
            MatchupFactor(title: "Styles of Play", detail: "Team struggles against fast teams"),
            MatchupFactor(title: "Offensive vs Defensive Schemes", detail: "Opponent uses a strong zone defense")
        ]
        
        self.scenarioFactors = [
            ScenarioFactor(title: "Home vs Away", detail: "Game is an away game"),
            ScenarioFactor(title: "Weather Conditions", detail: "Clear skies expected")
        ]
        
        self.externalFactors = [
            ExternalFactor(title: "Venue and Crowd", detail: "High home field advantage"),
            ExternalFactor(title: "Officiating", detail: "Experienced referees")
        ]
        
        self.performanceVariance = [
            PerformanceVariance(title: "Historical Performance", detail: "Player averages 20 points against this opponent"),
            PerformanceVariance(title: "Impact of Fatigue", detail: "Player's performance drops by 10% in back-to-back games")
        ]
    }
}

