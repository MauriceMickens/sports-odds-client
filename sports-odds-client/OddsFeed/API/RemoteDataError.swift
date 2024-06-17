//
//  RemoteEmployeeFeedError.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

enum RemoteDataError: Error {
    case missingURL
    case network(error: Error)
    case decoding(error: Error)

    var reason: String {
        switch self {
        case .missingURL:
            return "URL is nil"
        case .network(let error):
            return "An error occurred while fetching data: \(error) "
        case .decoding(let error):
            return "An error occurred while decoding data: \(error) "
        }
    }
}
