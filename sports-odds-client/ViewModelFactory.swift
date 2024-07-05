//
//  ViewModelFactory.swift
//  sports-odds-client
//
//  Created by Mickens on 6/30/24.
//

import Foundation

final class ViewModelFactory: ObservableObject {
    let remoteDataLoader: any DataLoader
    let authenticationManager: AuthenticationManagerProtocol
    weak var appState: AppState?
    
    init(
        authenticationManager: AuthenticationManagerProtocol,
        remoteDataLoader: any DataLoader,
        appState: AppState
    ) {
        self.authenticationManager = authenticationManager
        self.remoteDataLoader = remoteDataLoader
        self.appState = appState
    }
    
    @MainActor
    func makeOddsViewModel() -> OddsViewModel {
        return OddsViewModel(
            baseUrl: Environment.local.baseURL,
            remoteDataLoader: remoteDataLoader
        )
    }
    
    @MainActor
    func makeSignInEmailViewModel() -> SignInEmailViewModel? {
        guard let appState = appState else {
            return nil
        }
        return SignInEmailViewModel(authenticationManager: authenticationManager, appState: appState)
    }
    
    @MainActor
    func makeSettingsViewModel() -> SettingsViewModel {
        return .init(authenticationManager: authenticationManager)
    }
    
    @MainActor
    func makeCreateAccountViewModel() -> CreateAccountViewModel? {
        guard let appState = appState else {
            return nil
        }
        return CreateAccountViewModel(authenticationManager: authenticationManager)
    }
}

