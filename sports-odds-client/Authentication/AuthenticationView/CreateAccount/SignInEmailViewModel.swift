//
//  SignInEmailViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var loadingState: LoadingState<DBUser, RemoteDataError> = .idle
    @Published var email = ""
    @Published var password = ""
    
    private var authenticationManager: AuthenticationManagerProtocol
    private var appState: AppState
    
    init(authenticationManager: AuthenticationManagerProtocol, appState: AppState) {
        self.authenticationManager = authenticationManager
        self.appState = appState
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
            appState.isSignedIn = true
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
}
