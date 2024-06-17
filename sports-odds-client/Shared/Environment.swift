//
//  Environment.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Foundation

enum Environment {
    case dev
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://uolauloiv6.execute-api.us-east-1.amazonaws.com/dev/")!
        }
    }
}
