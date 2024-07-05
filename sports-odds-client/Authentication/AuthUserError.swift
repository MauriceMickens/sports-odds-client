//
//  AuthUserError.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/5/24.
//

import Foundation

enum AuthUserError: Error {
    case network(error: Error)
    case invalidEmail
    case invalidPassword
    case emailNotFound
    case userNotFound
    case unknown(error: Error)
    
    var reason: String {
        switch self {
        case .network(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidEmail:
            return "The email address is invalid."
        case .invalidPassword:
            return "The password is invalid."
        case .emailNotFound:
            return "No user found with this email."
        case .userNotFound:
            return "User not found."
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
