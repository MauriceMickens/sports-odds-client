//
//  SignInEmailView.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import SwiftUI

struct SignInEmailView: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            VStack(spacing: 15) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            }
            .padding(.horizontal)

            if case let .error(error) = viewModel.loadingState {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }

            Button(action: {
                Task {
                    await viewModel.signIn()
                }
            }) {
                if case .loading = viewModel.loadingState {
                    ProgressView()
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                } else {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(
                viewModel: SignInEmailViewModel(
                    authenticationManager: MockAuthenticationManager(isSignedIn: false),
                    appState: AppState(authenticationManager: MockAuthenticationManager(isSignedIn: false))
                )
            )
        }
    }
}
