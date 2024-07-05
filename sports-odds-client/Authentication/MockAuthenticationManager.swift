//
//  MockAuthenticationManager.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/5/24.
//

import Foundation

class MockAuthenticationManager: AuthenticationManagerProtocol {
    
    var isSignedIn: Bool
    
    init(isSignedIn: Bool) {
        self.isSignedIn = isSignedIn
    }
    
    func updateSignInState(isSignedIn: Bool) {
        
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        return .init()
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        return []
    }
    
    func signOut() throws {}
    
    func delete() async throws {}
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        return .init()
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        return .init()
    }
    
    func resetPassword(email: String) async throws {}
    
    func updatePassword(password: String) async throws {}
    
    func updateEmail(email: String) async throws {}
    
    func linkEmail(email: String, password: String) async throws -> AuthDataResultModel {
        return .init()
    }
    
    func linkGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        return .init()
    }
    
    func linkApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        return .init()
    }
}
