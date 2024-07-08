//
//  URL+Endpoints.swift
//  sports-odds-client
//
//  Created by Mickens on 6/29/24.
//

import Foundation

extension URL {
    static func makeConfigURL(base: String) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/api/v1/config"
        return components?.url
    }
    
    static func makeOddsURL(base: String, sport: String, page: Int, limit: Int) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/api/v1/odds"
        components?.queryItems = [
            URLQueryItem(name: "sport", value: sport),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        return components?.url
    }

    static func makeCreateUserURL(base: String) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/api/v1/users"
        return components?.url
    }

    static func makeGetUserURL(base: String, userId: String) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/api/v1/users/\(userId)"
        return components?.url
    }

    static func makeUpdateUserURL(base: String, userId: String) -> URL? {
        var components = URLComponents(string: base)
        components?.path = "/api/v1/users/\(userId)"
        return components?.url
    }
}
