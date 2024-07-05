//
//  CreateAccountViewModel.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/5/24.
//

import Foundation

enum CreateAccountError: Error, LocalizedError {
    case emptyFields
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "Email or password cannot be empty."
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

@MainActor
final class CreateAccountViewModel: ObservableObject {
    @Published var loadingState: LoadingState<DBUser, CreateAccountError> = .idle
    @Published var email = ""
    @Published var password = ""

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
            authenticationManager.updateSignInState(isSignedIn: true)
            loadingState = .loaded(objects: user)
        } catch {
            loadingState = .error(error: .networkError(error))
        }
    }
}
