//
//  RemoteImageLoader.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation
import UIKit

class RemoteImageLoader: ImageLoader {
    let client: HTTPClient
    
    required init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load(url: URL) async throws -> UIImage {
        do {
            let (data, response) = try await client.get(from: url)
            
            guard response.statusCode == 200 else {
                throw RemoteDataError.network(error: URLError(.badServerResponse))
            }
            
            let result: Result<UIImage, DataError> = DataMapper.map(data)
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
