//
//  AppState.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation

final class AppState: ObservableObject {
    @Published var isSignedIn: Bool
    let authenticationManager: AuthenticationManagerProtocol
    var viewModelFactory: ViewModelFactory? = nil
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
        self.isSignedIn = authenticationManager.isSignedIn
        
        // Now we can safely initialize viewModelFactory
        self.viewModelFactory = ViewModelFactory(
            authenticationManager: authenticationManager,
            remoteDataLoader: RemoteDataLoader(),
            appState: self
        )
        
        // Observe changes to the authentication manager's isSignedIn property
        (authenticationManager as? AuthenticationManager)?.$isSignedIn
            .assign(to: &$isSignedIn)
        
        authenticateUser()
    }
    
    private func authenticateUser() {
        do {
            _ = try authenticationManager.getAuthenticatedUser()
        } catch {
            print("error authenticating user")
        }
    }
}
