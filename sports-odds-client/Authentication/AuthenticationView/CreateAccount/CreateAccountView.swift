//
//  CreateAccountView.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/5/24.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var viewModel: CreateAccountViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Create Your Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.none)
                .padding(.horizontal)

            if case let .error(error) = viewModel.loadingState {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
            }

            Button(action: {
                Task {
                    await handleSignUp()
                }
            }) {
                if case .loading = viewModel.loadingState {
                    ProgressView()
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                } else {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
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
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                    Text("Create Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private func handleSignUp() async {
        await viewModel.signUp()
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateAccountView(viewModel: CreateAccountViewModel(authenticationManager: MockAuthenticationManager(isSignedIn: false)))
        }
    }
}

