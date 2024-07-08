//
//  AuthenticationView.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct AuthenticationView: View {
    
    @SwiftUI.Environment(AuthenticationManager.self) var authenticationManager
    @State var viewModel: AuthenticationViewModel
    
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            NavigationLink(destination: SignInEmailView(viewModel: .init(authenticationManager: authenticationManager))) {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
            }

            NavigationLink(destination: CreateAccountView(viewModel: .init(authenticationManager: authenticationManager))) {
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
                    await handleSignIn { await viewModel.signInGoogle() }
                }
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)

            Button(action: {
                Task {
                    await handleSignIn { await viewModel.signInApple() }
                }
            }) {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
                    .frame(height: 55)
            }
            
            if case let .error(error) = viewModel.loadingState {
               Text(error.reason)
                   .foregroundColor(.red)
                   .multilineTextAlignment(.center)
                   .padding()
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
            AuthenticationView(
                viewModel: AuthenticationViewModel(
                    baseUrl: Environment.local.baseURL,
                    remoteDataLoader: MockRemoteDataLoader(),
                    authenticationManager: MockAuthenticationManager(isSignedIn: false)
                )
            )
        }
    }
}
