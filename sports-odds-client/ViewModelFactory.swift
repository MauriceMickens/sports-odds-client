//
//  ViewModelFactory.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation

final class ViewModelFactory {
    let client: URLSessionHTTPClient
    let remoteDataLoader: RemoteDataLoader
    
    init() {
        self.client = URLSessionHTTPClient()
        self.remoteDataLoader = RemoteDataLoader(client: client)
    }
    
    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            baseUrl: Environment.local.baseURL,
            remoteDataLoader: remoteDataLoader
        )
    }
}
