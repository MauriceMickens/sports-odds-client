//
//  SettingsViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation
import Observation

@MainActor @Observable
final class SettingsViewModel: ObservableObject {
    
    var authProviders: [AuthProviderOption] = []
    var authUser: AuthDataResultModel? = nil
    var loadingState: LoadingState<Void, AuthUserError> = .idle
    
    private var authenticationManager: AuthenticationManagerProtocol
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }

    func loadAuthProviders() {
        loadingState = .loading
        do {
            let providers = try authenticationManager.getProviders()
            authProviders = providers
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .unknown(error: error))
        }
    }
    
    func loadAuthUser() {
        loadingState = .loading
        do {
            authUser = try authenticationManager.getAuthenticatedUser()
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .unknown(error: error))
        }
    }
    
    func signOut() async {
        loadingState = .loading
        do {
            try authenticationManager.signOut()
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func deleteAccount() async {
        loadingState = .loading
        do {
            try await authenticationManager.delete()
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func resetPassword() async {
        loadingState = .loading
        do {
            let authUser = try authenticationManager.getAuthenticatedUser()
            guard let email = authUser.email else {
                loadingState = .error(error: .emailNotFound)
                return
            }
            try await authenticationManager.resetPassword(email: email)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func updateEmail() async {
        loadingState = .loading
        do {
            let email = "hello123@gmail.com"
            try await authenticationManager.updateEmail(email: email)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func updatePassword() async {
        loadingState = .loading
        do {
            let password = "Hello123!"
            try await authenticationManager.updatePassword(password: password)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func linkGoogleAccount() async {
        loadingState = .loading
        do {
            let helper = SignInGoogleHelper()
            let tokens = try await helper.signIn()
            authUser = try await authenticationManager.linkGoogle(tokens: tokens)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func linkAppleAccount() async {
        loadingState = .loading
        do {
            let helper = SignInAppleHelper()
            let tokens = try await helper.startSignInWithAppleFlow()
            authUser = try await authenticationManager.linkApple(tokens: tokens)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
    
    func linkEmailAccount() async {
        loadingState = .loading
        do {
            let email = "anotherEmail@gmail.com"
            let password = "Hello123!"
            authUser = try await authenticationManager.linkEmail(email: email, password: password)
            loadingState = .loaded(objects: ())
        } catch {
            loadingState = .error(error: .network(error: error))
        }
    }
}
