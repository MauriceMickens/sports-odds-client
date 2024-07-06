//
//  AuthenticationViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Observation
import SwiftUI

@MainActor @Observable
final class AuthenticationViewModel {
    var loadingState: LoadingState<DBUser, AuthUserError> = .idle
    
    private var authenticationManager: AuthenticationManagerProtocol
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }
    
    func signInGoogle() async {
        loadingState = .loading
        do {
            let helper = SignInGoogleHelper()
            let tokens = try await helper.signIn()
            let authDataResult = try await authenticationManager.signInWithGoogle(tokens: tokens)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
            loadingState = .loaded(objects: user)
            authenticationManager.isSignedIn = true
        } catch {
            handleError(error)
        }
    }
    
    func signInApple() async {
        loadingState = .loading
        do {
            let helper = SignInAppleHelper()
            let tokens = try await helper.startSignInWithAppleFlow()
            let authDataResult = try await authenticationManager.signInWithApple(tokens: tokens)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
            loadingState = .loaded(objects: user)
            authenticationManager.isSignedIn = true
        } catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        // Log the error for debugging purposes
        print("Error: \(error.localizedDescription)")

        // Map the error to AuthUserError and set the loading state
        let authError = mapErrorToAuthUserError(error)
        loadingState = .error(error: authError)
    }
    
    private func mapErrorToAuthUserError(_ error: Error) -> AuthUserError {
        if let urlError = error as? URLError {
            return .network(error: urlError)
        }
        // Add more error mappings as needed
        return .unknown(error: error)
    }
}

