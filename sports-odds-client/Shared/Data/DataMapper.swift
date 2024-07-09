//
//  DataMapper.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation
import UIKit

final class DataMapper {
    static func map<T: Decodable>(_ data: Data) -> Result<T, RemoteDataError> {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(T.self, from: data)
                return .success(result)
            } catch let decodingError as DecodingError {
                printDecodingError(decodingError)
                return .failure(.decoding(error: decodingError))
            } catch {
                return .failure(.decoding(error: error))
            }
        }

    static func map(_ data: Data) -> Result<UIImage, RemoteDataError> {
        guard let image = UIImage(data: data) else {
            return .failure(.missingImageData)
        }
        return .success(image)
    }
    
    private static func printDecodingError(_ error: DecodingError) {
            switch error {
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .valueNotFound(let type, let context):
                print("Value '\(type)' not found:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .keyNotFound(let key, let context):
                print("Key '\(key)' not found:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            case .dataCorrupted(let context):
                print("Data corrupted:", context.debugDescription)
                print("CodingPath:", context.codingPath)
            @unknown default:
                print("Unknown decoding error:", error.localizedDescription)
            }
        }
}
