//
//  URLSessionHTTPClient.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL) async throws -> HTTPClientResponse {
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unexpectedValue
            }
            
            guard 200..<299 ~= httpResponse.statusCode else {
                throw NetworkError.nonSuccessStatusCode
            }
            
            return (data: data, response: httpResponse)
        } catch {
            throw NetworkError.network(error: error)
        }
    }
}
