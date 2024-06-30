//
//  Config.swift
//  sports-odds-client
//
//  Created by Mickens on 6/28/24.
//

import Foundation

struct Config: Decodable {
    let activeSports: [String: SportConfig]
    
    enum CodingKeys: String, CodingKey {
        case activeSports = "active_sports"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activeSports = try container.decode([String: SportConfig].self, forKey: .activeSports)
    }
}

struct SportConfig: Decodable {
    let index: Int
    let active: Bool
    let markets: [Market]
    
    enum CodingKeys: String, CodingKey {
        case index, active, markets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.index = try container.decode(Int.self, forKey: .index)
        self.active = try container.decode(Bool.self, forKey: .active)
        self.markets = try container.decodeIfPresent([Market].self, forKey: .markets) ?? []
    }
}

struct Market: Identifiable, Decodable, Hashable {
    let id = UUID()
    let key: String
    let description: String
}
