//
//  NetworkError.swift
//  block
//
//  Created by Mmickens on 3/28/22.
//

import Foundation

enum NetworkError: Error {
    case network(error: Error)
    case nonSuccessStatusCode
    case missingData
    case unexpectedValue

    var reason: String {
        switch self {
        case .network(let error):
            return "An error occurred while fetching data: \(error) "
        case .nonSuccessStatusCode:
            return "Status code not in (200s) but no error was returned"
        case .missingData:
            return "Data is nil from the network response"
        case .unexpectedValue:
            return "Something went horribly wrong"
        }
    }
}
