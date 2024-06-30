//
//  Environment.swift
//  sports-odds-client
//
//  Created by Mickens on 6/16/24.
//

import Foundation

enum Environment {
    case local
    case dev
    
    var baseURL: URL {
        switch self {
        case .local:
            return URL(string: "http://127.0.0.1:8000/")!
        case .dev:
            return URL(string: "https://uolauloiv6.execute-api.us-east-1.amazonaws.com/dev/")!
        }
    }
}
