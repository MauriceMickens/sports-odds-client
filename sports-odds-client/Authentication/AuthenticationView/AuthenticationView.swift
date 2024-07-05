//
//  AuthenticationView.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            if let viewModelFactory = appState.viewModelFactory,
               let signInEmailViewModel = viewModelFactory.makeSignInEmailViewModel(),
               let createAccountViewModel = viewModelFactory.makeCreateAccountViewModel() {
                
                NavigationLink(destination: SignInEmailView(viewModel: signInEmailViewModel)) {
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }

                NavigationLink(destination: CreateAccountView(viewModel: createAccountViewModel)) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }

                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        await handleSignIn { try await viewModel.signInGoogle() }
                    }
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)

                Button(action: {
                    Task {
                        await handleSignIn { try await viewModel.signInApple() }
                    }
                }) {
                    Text("Sign In with Apple")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
            } else {
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.gray)
            }

            Spacer()
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                    Text("Sign In or Create Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private func handleSignIn(action: @escaping () async throws -> Void) async {
        do {
            try await action()
        } catch {
            print(error)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView().environmentObject(AppState(authenticationManager: MockAuthenticationManager(isSignedIn: false)))
        }
    }
}
