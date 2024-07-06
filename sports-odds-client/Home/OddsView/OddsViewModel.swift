//
//  HomeViewModel.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Combine
import Foundation
import Observation

@MainActor @Observable
final class OddsViewModel: ViewModelProtocol {
    typealias ObjectType = Odds
    typealias StateType = [Odds]
    
    var loadingState: LoadingState<[Odds], RemoteDataError> = .loading
    var hasMore = true
    var dataLoaded = false
    
    var selectedSport: Sport = .init(key: "", description: "") {
        didSet {
            filterSports()
        }
    }
    var selectedMarket: Market = .init(key: "", description: "") {
        didSet {
            filterOdds()
        }
    }
    
    var objects: [Odds] = []
    var activeSports: [Sport] = []
    var activeMarkets: [Market] = []
    var filteredObjects: [Odds] = []
    
    private let baseUrl: URL
    private let remoteDataLoader: any DataLoader
    
    private var page = 1
    private let limit = 50
    private var loadTask: Task<Void, Never>?
    
    init(baseUrl: URL, remoteDataLoader: any DataLoader) {
        self.baseUrl = baseUrl
        self.remoteDataLoader = remoteDataLoader
    }
    
    func loadData() async throws {
        guard !dataLoaded else { return }
        
        loadTask?.cancel() // Cancel any ongoing task
        loadTask = Task {
            do {
                let config = try await loadConfig()
                try await loadOdds(for: config)
                dataLoaded = true
            } catch {
                loadingState = .error(error: .network(error: error))
            }
        }
        await loadTask?.value
    }
    
    func refreshData() async throws {
        page = 1
        objects.removeAll()
        dataLoaded = false
        try await loadData()
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
        
        activeSports = sortedSports.map {
            .init(
                key: $0.key,
                description: $0.value.description
            )
        }
        
        activeMarkets = firstSport.value.markets.map {
            .init(
                key: $0.key,
                description: $0.description
            )
        }
        
        guard let feedUrl = URL.makeOddsURL(
            base: baseUrl.absoluteString,
            sport: firstSport.key, 
            page: page,
            limit: limit
        ) else {
            loadingState = .error(error: .missingURL)
            return
        }
        
        let newOdds: [Odds] = try await remoteDataLoader.load(url: feedUrl)
        objects.append(contentsOf: newOdds)
        
        if let market = firstSport.value.markets.first {
            selectedMarket = market
        }
        
        loadingState = .loaded(objects: objects)
        page += 1
        hasMore = !newOdds.isEmpty
    }
    
    func filterSports() {

    }
    
    func filterOdds() {
        filteredObjects = objects.filter { $0.market == selectedMarket.key }
    }
}

