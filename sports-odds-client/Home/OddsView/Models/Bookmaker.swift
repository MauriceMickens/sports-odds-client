
//
//  Bookmaker.swift
//  sports-odds-client
//
//  Created by Mickens on 7/3/24.
//

import Foundation

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
