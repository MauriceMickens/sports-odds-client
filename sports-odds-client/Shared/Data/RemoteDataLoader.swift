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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            // Check for successful status code
            guard 200..<300 ~= httpResponse.statusCode else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            // Log successful HTTP response for debugging
            print("Received HTTP response: \(httpResponse)")
            
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
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            // Check for successful status code
            guard 200..<300 ~= httpResponse.statusCode else {
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
    
    func post<RequestModel: Encodable, ResponseModel: Decodable>(
        url: URL,
        body: RequestModel
    ) async throws -> ResponseModel {
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(body)
            
            let (data, response) = try await client.post(request: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            // Check for successful status code
            guard 200..<300 ~= httpResponse.statusCode else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            let result: Result<ResponseModel, RemoteDataError> = DataMapper.map(data)
            switch result {
            case .success(let responseModel):
                return responseModel
            case .failure(let error):
                throw RemoteDataError.decoding(error: error)
            }
        } catch {
            throw RemoteDataError.network(error: error)
        }
    }
}

