//
//  MockDataLoader.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/6/24.
//

import Foundation
import UIKit

class MockRemoteDataLoader: DataLoader {
    typealias FailureModel = RemoteDataError
    
    func load<Model>(url: URL) async throws -> Model where Model : Decodable {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Create a mock response based on the type of Model
        // This is a simple example, you should replace it with your own mock data logic
        if let mockModel = MockData.mockModel(for: Model.self) {
            return mockModel
        } else {
            throw RemoteDataError.decoding(error: NSError(domain: "Mock", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create mock model"]))
        }
    }
    
    func load(url: URL) async throws -> UIImage {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Return a dummy image (replace with your own mock image logic if needed)
        return UIImage(systemName: "person.fill") ?? UIImage()
    }
    
    func post<RequestModel, ResponseModel>(url: URL, body: RequestModel) async throws -> ResponseModel where RequestModel : Encodable, ResponseModel : Decodable {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Create a mock response based on the type of ResponseModel
        // This is a simple example, you should replace it with your own mock data logic
        if let mockResponseModel = MockData.mockModel(for: ResponseModel.self) {
            return mockResponseModel
        } else {
            throw RemoteDataError.decoding(error: NSError(domain: "Mock", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create mock response model"]))
        }
    }
}

// MockData helper for generating mock models
class MockData {
    static func mockModel<Model: Decodable>(for type: Model.Type) -> Model? {
        switch type {
        case is DBUser.Type:
            // Return a mock DBUser instance
            return DBUser(userId: "mock_user_id", email: "mock@example.com") as? Model
        // Add cases for other models you need to mock
        default:
            return nil
        }
    }
}
