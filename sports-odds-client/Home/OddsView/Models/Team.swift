//
//  Team.swift
//  sports-odds-client
//
//  Created by Mickens on 7/3/24.
//

import Foundation

struct Team: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let abbreviation: String
    let city: String
    let playerPosition: String
    
    enum CodingKeys: String, CodingKey {
        case id = "team_id"
        case name = "team_name"
        case abbreviation = "team_abbreviation"
        case city = "team_city"
        case playerPosition = "player_position"
    }
    
    init(id: Int, name: String, abbreviation: String, city: String, playerPosition: String) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.city = city
        self.playerPosition = playerPosition
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? UUID().hashValue
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        abbreviation = try container.decodeIfPresent(String.self, forKey: .abbreviation) ?? ""
        city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        playerPosition = try container.decodeIfPresent(String.self, forKey: .playerPosition) ?? ""
    }
}
