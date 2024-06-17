//
//  DataMapper.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation
import UIKit

final class DataMapper {
    static func map<T: Decodable>(_ data: Data) -> Result<T, DataError> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.decoding(error: error))
        }
    }

    static func map(_ data: Data) -> Result<UIImage, DataError> {
        guard let image = UIImage(data: data) else {
            return .failure(.missingData)
        }
        return .success(image)
    }
}
