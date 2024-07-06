//
//  AuthenticationManager.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation
import FirebaseAuth
import Observation

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

protocol AuthenticationManagerProtocol {
    
    var isSignedIn: Bool { get set }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func getProviders() throws -> [AuthProviderOption]
    func signOut() throws
    func delete() async throws
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async throws
    func updateEmail(email: String) async throws
    
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel
    func linkGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel
    
    func updateSignInState(isSignedIn: Bool)
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel
}

@Observable
final class AuthenticationManager: AuthenticationManagerProtocol {
    
    var isSignedIn: Bool = false
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            isSignedIn = false
            throw URLError(.badServerResponse)
        }
        
        isSignedIn = true
        
        return AuthDataResultModel(user: user)
    }
        
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        print(providers)
        return providers
    }
        
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            isSignedIn = true
            throw error
        }
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        do {
            try await user.delete()
            isSignedIn = false
        } catch {
            isSignedIn = true
            throw error
        }
    }
    
    func updateSignInState(isSignedIn: Bool) {
        self.isSignedIn = isSignedIn
    }
}

// MARK: SIGN IN EMAIL

extension AuthenticationManager {
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updateEmail(to: email)
    }

}

// MARK: SIGN IN SSO

extension AuthenticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

// MARK: SIGN IN ANONYMOUS

extension AuthenticationManager {
    
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    }
    
    func linkGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await linkCredential(credential: credential)
    }
    
    func linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await linkCredential(credential: credential)
    }
    
    private func linkCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        let authDataResult = try await user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
}
