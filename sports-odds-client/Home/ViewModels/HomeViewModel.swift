//
//  HomeViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var hasMore = true
    @Published var odds: [Odds] = []
    
    private let feedloader: RemoteOddsFeedLoader
    private let imageLoader: ImageLoader
    
    private let baseUrl: URL
    
    private(set) var page = 1
    private let sport = "basketball_nba"
    private let limit = 50
    
    init(
        baseUrl: URL,
        feedloader: RemoteOddsFeedLoader,
        imageLoader: ImageLoader
    ) {
        self.feedloader = feedloader
        self.baseUrl = baseUrl
        self.imageLoader = imageLoader
    }
    
    func loadOdds() async {
        isLoading = true
        
        guard let feedUrl = URL.makeOddsURL(
            base: baseUrl.absoluteString,
            sport: sport,
            page: page,
            limit: limit
        ) else {
            print("Failed to construct URL")
            isLoading = false
            return
        }
        
        do {
            let newOdds = try await feedloader.load(url: feedUrl)
            odds.append(contentsOf: newOdds)
            page += 1
            hasMore = !newOdds.isEmpty
        } catch let error as RemoteDataError {
            print("Failed to load odds: \(error.reason)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
        isLoading = false
    }
}


extension URL {
    static func makeOddsURL(base: String, sport: String, page: Int, limit: Int) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/dev/api/v1/odds"
        components?.queryItems = [
            URLQueryItem(name: "sport", value: sport),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        return components?.url
    }
}
