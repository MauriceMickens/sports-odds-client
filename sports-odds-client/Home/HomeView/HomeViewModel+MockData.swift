//
//  HomeViewModel+MockData.swift
//  sports-odds-client
//
//  Created by Mickens on 6/29/24.
//

import Foundation

extension HomeViewModel {
    static func mock(count: Int = 1) -> HomeViewModel {
        var mockOdds: [Odds] = []
        for _ in 0..<count {
            mockOdds.append(.init(
                uniqueId: UUID().uuidString,
                player: "Skylar Diggins-Smith",
                eventId: "7556b7adaeb9972d8795d0cbf45152dd",
                market: "player_threes",
                awayTeam: "Connecticut Sun",
                homeTeam: "Seattle Storm",
                gameDate: "2024-06-23 15:00:00 EDT-0400",
                sport: "basketball_wnba",
                playerImageUrls: nil,
                bookmakers: [
                    Bookmaker(
                        bookmaker: "FanDuel",
                        betType: "Under",
                        price: -245,
                        point: 1.5,
                        impliedProbability: 0.7101,
                        amountWon: 0.4082,
                        expectedValue: -0.00003718,
                        lastUpdate: "2024-06-23 13:45:12 EDT-0400"
                    ),
                    Bookmaker(
                        bookmaker: "BetRivers",
                        betType: "Over",
                        price: 170,
                        point: 1.5,
                        impliedProbability: 0.3704,
                        amountWon: 1.7,
                        expectedValue: 0.00008,
                        lastUpdate: "2024-06-23 13:45:48 EDT-0400"
                    )
                ]
            ))
        }
        
        let viewModel = HomeViewModel(
            baseUrl: URL(string: "https://example.com/odds")!,
            remoteDataLoader: RemoteDataLoader(client: URLSessionHTTPClient())
        )
        viewModel.objects = mockOdds
        viewModel.loadingState = .loaded(objects: mockOdds)
        return viewModel
    }
}
