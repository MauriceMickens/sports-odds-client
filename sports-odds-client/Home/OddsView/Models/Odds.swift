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
    let team: Team?
    
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
        case team = "team_info"
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
        bookmakers: [Bookmaker],
        team: Team
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
        self.team = team
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
        team = try container.decodeIfPresent(Team.self, forKey: .team)
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
            ],
            team: Team(
                id: 012345,
                name: "name",
                abbreviation: "abbreviation",
                city: "city",
                playerPosition: "position"
            )
        )
    }
}
