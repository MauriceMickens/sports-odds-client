//
//  RemoteDataLooader.swift
//  sports-odds-client
//
//  Created by Mickens on 6/29/24.
//

import Foundation
import Observation
import UIKit

@Observable
final class RemoteDataLoader: DataLoader {
    
    typealias FailureModel = RemoteDataError
    
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load<Model: Decodable>(url: URL) async throws -> Model {
        do {
                // Log request URL for debugging
            print("Loading data from URL: \(url)")
            
            let (data, response) = try await client.get(from: url)
            
            guard response.statusCode == 200 else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
                // Log successful HTTP response for debugging
            print("Received HTTP response: \(response)")
            
            let result: Result<Model, RemoteDataError> = DataMapper.map(data)
            
            switch result {
            case .success(let object):
                    // Log successful decoding for debugging
                print("Decoded object: \(object)")
                return object
            case .failure(let error):
                    // Log decoding failure for debugging
                print("Decoding error: \(error)")
                throw RemoteDataError.decoding(error: error)
            }
        } catch {
                // Log network error for debugging
            print("Network error: \(error)")
            throw RemoteDataError.network(error: error)
        }
    }
    
    func load(url: URL) async throws -> UIImage {
        do {
            let (data, response) = try await client.get(from: url)
            
            guard response.statusCode == 200 else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            let result: Result<UIImage, RemoteDataError> = DataMapper.map(data)
            switch result {
            case .success(let image):
                return image
            case .failure(let error):
                throw RemoteDataError.decoding(error: error)
            }
        } catch {
            throw RemoteDataError.network(error: error)
        }
    }
}

