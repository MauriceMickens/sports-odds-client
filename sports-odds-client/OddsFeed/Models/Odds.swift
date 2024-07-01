import Foundation

struct Odds: Identifiable, Decodable, Hashable {
    let id: UUID
    let uniqueId: String
    let player: String
    let eventId: String
    let market: String
    let awayTeam: String
    let homeTeam: String
    let gameDate: String
    let sport: String
    let playerImageUrls: PlayerImageUrls?
    let bookmakers: [Bookmaker]
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case player
        case eventId = "event_id"
        case market
        case awayTeam = "away_team"
        case homeTeam = "home_team"
        case gameDate = "game_date"
        case sport
        case playerImageUrls = "player_image_urls"
        case bookmakers
    }
    
    init(
        id: UUID = UUID(),
        uniqueId: String,
        player: String,
        eventId: String,
        market: String,
        awayTeam: String,
        homeTeam: String,
        gameDate: String,
        sport: String,
        playerImageUrls: PlayerImageUrls?,
        bookmakers: [Bookmaker]
    ) {
        self.id = id
        self.uniqueId = uniqueId
        self.player = player
        self.eventId = eventId
        self.market = market
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.gameDate = gameDate
        self.sport = sport
        self.playerImageUrls = playerImageUrls
        self.bookmakers = bookmakers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        uniqueId = try container.decode(String.self, forKey: .uniqueId)
        player = try container.decode(String.self, forKey: .player)
        eventId = try container.decode(String.self, forKey: .eventId)
        market = try container.decode(String.self, forKey: .market)
        awayTeam = try container.decode(String.self, forKey: .awayTeam)
        homeTeam = try container.decode(String.self, forKey: .homeTeam)
        gameDate = try container.decode(String.self, forKey: .gameDate)
        sport = try container.decode(String.self, forKey: .sport)
        playerImageUrls = try container.decodeIfPresent(PlayerImageUrls.self, forKey: .playerImageUrls)
        bookmakers = try container.decode([Bookmaker].self, forKey: .bookmakers)
    }
    
    static var random: Odds {
        Odds(
            uniqueId: UUID().uuidString,
            player: "Random Player",
            eventId: UUID().uuidString,
            market: "player_points",
            awayTeam: "Random Away Team",
            homeTeam: "Random Home Team",
            gameDate: "2024-06-23 15:00:00 EDT-0400",
            sport: "basketball_nba",
            playerImageUrls: nil,
            bookmakers: [
                Bookmaker.random,
                Bookmaker.random
            ]
        )
    }
}

struct PlayerImageUrls: Decodable, Hashable {
    let originalURL: URL
    let thumbnailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case originalURL = "original_url"
        case thumbnailURL = "thumbnail_url"
    }
    
    static var random: PlayerImageUrls {
        PlayerImageUrls(
            originalURL: URL(string: "https://example.com/original.png")!,
            thumbnailURL: URL(string: "https://example.com/thumbnail.png")!
        )
    }
}

struct Bookmaker: Identifiable, Decodable, Hashable {
    let id: UUID
    let bookmaker: String
    let betType: String
    let price: Int
    let point: Double
    let impliedProbability: Double
    let amountWon: Double
    let expectedValue: Double
    let lastUpdate: String
    
    enum CodingKeys: String, CodingKey {
        case bookmaker
        case betType = "bet_type"
        case price
        case point
        case impliedProbability = "implied_probability"
        case amountWon = "amount_won"
        case expectedValue = "expected_value"
        case lastUpdate = "last_update"
    }
    
    init(
        id: UUID = UUID(),
        bookmaker: String,
        betType: String,
        price: Int,
        point: Double,
        impliedProbability: Double,
        amountWon: Double,
        expectedValue: Double,
        lastUpdate: String
    ) {
        self.id = id
        self.bookmaker = bookmaker
        self.betType = betType
        self.price = price
        self.point = point
        self.impliedProbability = impliedProbability
        self.amountWon = amountWon
        self.expectedValue = expectedValue
        self.lastUpdate = lastUpdate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.bookmaker = try container.decode(String.self, forKey: .bookmaker)
        self.betType = try container.decode(String.self, forKey: .betType)
        self.price = try container.decode(Int.self, forKey: .price)
        self.point = try container.decode(Double.self, forKey: .point)
        self.impliedProbability = try container.decode(Double.self, forKey: .impliedProbability)
        self.amountWon = try container.decode(Double.self, forKey: .amountWon)
        self.expectedValue = try container.decode(Double.self, forKey: .expectedValue)
        self.lastUpdate = try container.decode(String.self, forKey: .lastUpdate)
    }
    
    static var random: Bookmaker {
        Bookmaker(
            bookmaker: "Random Bookmaker",
            betType: "Over",
            price: Int.random(in: -200...200),
            point: Double.random(in: 1.0...10.0),
            impliedProbability: Double.random(in: 0.0...1.0),
            amountWon: Double.random(in: 0.0...100.0),
            expectedValue: Double.random(in: -1.0...1.0),
            lastUpdate: "2024-06-23 15:00:00 EDT-0400"
        )
    }
}
