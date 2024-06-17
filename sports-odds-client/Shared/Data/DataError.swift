//
//  DataError.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

enum DataError: Error {
    case decoding(error: Error)
    case missingData

    var reason: String {
        switch self {
        case .decoding(let error):
            return "An error occurred while decoding data: \(error) "
        case .missingData:
            return "Data is nil while mapping"
        }
    }
}
