//
//  Employee.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

struct Odds: Identifiable, Decodable, Hashable {
    let id = UUID()
    let awayTeam: String
    let lastUpdate: Date
    let player: String
    let bookmaker: String
    let amountWon: Double
    let sport: String
    let market: String
    let impliedProbability: Double
    let gameDate: String
    let homeTeam: String
    let betType: String
    let eventId: String
    let expectedValue: Double
    let point: Double
    let price: Int
    let playerImageUrls: PlayerImageUrls?
    
    enum CodingKeys: String, CodingKey {
        case awayTeam = "away_team"
        case lastUpdate = "last_update"
        case player
        case bookmaker
        case amountWon = "amount_won"
        case sport
        case market
        case impliedProbability = "implied_probability"
        case gameDate = "game_date"
        case homeTeam = "home_team"
        case betType = "bet_type"
        case eventId = "event_id"
        case expectedValue = "expected_value"
        case point
        case price
        case playerImageUrls = "player_image_urls"
    }
}

struct PlayerImageUrls: Decodable, Hashable {
    let originalURL: URL
    let thumbnailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case originalURL = "OriginalURL"
        case thumbnailURL = "ThumbnailURL"
    }
}



