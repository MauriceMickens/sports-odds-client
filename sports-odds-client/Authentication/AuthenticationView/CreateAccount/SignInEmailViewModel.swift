//
//  SignInEmailViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation
import Observation

@MainActor @Observable
final class SignInEmailViewModel {
    var loadingState: LoadingState<DBUser, RemoteDataError> = .idle
    var email = ""
    var password = ""
    
    private var authenticationManager: AuthenticationManagerProtocol
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }
    
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        loadingState = .loading
        
        do {
            let authDataResult = try await authenticationManager.signInUser(email: email, password: password)
            let user = DBUser(auth: authDataResult)
            loadingState = .loaded(objects: user)
            authenticationManager.isSignedIn = true
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
}
