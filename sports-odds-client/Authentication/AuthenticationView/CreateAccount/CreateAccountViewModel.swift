//
//  CreateAccountViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/5/24.
//

import Foundation
import Observation

enum CreateAccountError: Error {
    case networkError(Error)
    case emptyFields
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case unknown(Error)
    
    var reason: String {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .emptyFields:
            return "Email and password cannot be empty."
        case .invalidEmail:
            return "The email address is invalid."
        case .weakPassword:
            return "The password is too weak."
        case .emailAlreadyInUse:
            return "The email address is already in use."
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

@MainActor @Observable
final class CreateAccountViewModel: ObservableObject {
    var loadingState: LoadingState<DBUser, CreateAccountError> = .idle
    var email = ""
    var password = ""

    private var authenticationManager: AuthenticationManagerProtocol

    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }

    func signUp() async {
        guard !email.isEmpty, !password.isEmpty else {
            loadingState = .error(error: .emptyFields)
            return
        }

        loadingState = .loading

        do {
            let authDataResult = try await authenticationManager.createUser(email: email, password: password)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
            authenticationManager.isSignedIn = true
            loadingState = .loaded(objects: user)
        } catch {
            handleError(error)
        }
    }

    private func handleError(_ error: Error) {
        // Log the error for debugging purposes
        print("Error: \(error.localizedDescription)")

        // Map the error to CreateAccountError and set the loading state
        let createAccountError = mapErrorToCreateAccountError(error)
        loadingState = .error(error: createAccountError)
    }

    private func mapErrorToCreateAccountError(_ error: Error) -> CreateAccountError {
        if let urlError = error as? URLError {
            return .networkError(urlError)
        }
        // Add more specific error mappings as needed
        return .unknown(error)
    }
}
