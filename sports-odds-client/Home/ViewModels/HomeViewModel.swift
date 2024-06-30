//
//  HomeViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject, ViewModelProtocol {
    typealias ObjectType = Odds
    typealias StateType = [Odds]
    
    @Published var loadingState: LoadingState<[Odds]> = .loading
    @Published var hasMore = true
    @Published var selectedMarket: String = "" {
        didSet {
            filterOdds()
        }
    }
    
    @Published var objects: [Odds] = []
    @Published var activeSports: [String] = []
    @Published var activeMarkets: [Market] = []
    @Published var filteredObjects: [Odds] = []
    
    private let baseUrl: URL
    private let remoteDataLoader: any DataLoader
    
    private var page = 1
    private let limit = 50
    
    init(baseUrl: URL, remoteDataLoader: any DataLoader) {
        self.baseUrl = baseUrl
        self.remoteDataLoader = remoteDataLoader
    }
    
    func loadData() async throws {
        do {
            let config = try await loadConfig()
            try await loadOdds(for: config)
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    private func loadConfig() async throws -> Config? {
        guard let configUrl = URL.makeConfigURL(base: baseUrl.absoluteString) else {
            loadingState = .error(error: .missingURL)
            throw RemoteDataError.missingURL
        }
        
        let config: Config = try await remoteDataLoader.load(url: configUrl)
        return config
    }
    
    private func loadOdds(for config: Config?) async throws {
        guard let config = config else {
            loadingState = .error(error: .missingConfig)
            return
        }
        
        let sortedSports = config.activeSports
            .filter { $0.value.active }
            .sorted { $0.value.index < $1.value.index }
        
        guard let firstSport = sortedSports.first else {
            loadingState = .error(error: .missingConfig)
            return
        }
        
        activeSports = sortedSports.map { $0.key }
        activeMarkets = firstSport.value.markets
        
        guard let feedUrl = URL.makeOddsURL(base: baseUrl.absoluteString, sport: firstSport.key, page: page, limit: limit) else {
            loadingState = .error(error: .missingURL)
            return
        }
        
        let newOdds: [Odds] = try await remoteDataLoader.load(url: feedUrl)
        objects.append(contentsOf: newOdds)
        
        if let market = firstSport.value.markets.first {
            self.selectedMarket = market.key
        }
        
        loadingState = .loaded(objects: objects)
        page += 1
        hasMore = !newOdds.isEmpty
    }
    
    func filterOdds() {
        filteredObjects = objects.filter { $0.market == selectedMarket }
    }
}
