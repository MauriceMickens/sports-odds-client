//
//  RemoteEmployeeFeedLoader.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

final class RemoteOddsFeedLoader: FeedLoader {
    typealias SuccessModel = [Odds]
    typealias FailureModel = RemoteDataError
    
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load(url: URL) async throws -> [Odds] {
        do {
            let (data, response) = try await client.get(from: url)
            
            guard response.statusCode == 200 else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            let result: Result<[Odds], DataError> = DataMapper.map(data)
            switch result {
            case .success(let odds):
                return odds
            case .failure(let error):
                throw RemoteDataError.decoding(error: error)
            }
        } catch {
            throw RemoteDataError.network(error: error)
        }
    }
}


