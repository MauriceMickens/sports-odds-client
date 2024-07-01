//
//  Sport.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation

struct Sport: Identifiable, Decodable, Hashable {
    let id: UUID
    let key: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, key, description
    }
    
    init(id: UUID = UUID(), key: String, description: String) {
        self.id = id
        self.key = key
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.key = try container.decode(String.self, forKey: .key)
        self.description = try container.decode(String.self, forKey: .key)
    }
}
