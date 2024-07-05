//
//  SettingsView.swift
//  sports-odds-client
//
//  Created by Maurice Mickens on 7/4/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            case .error(let error):
                List {
                    errorView(error.reason)
                    logOutButton
                    deleteAccountButton
                    if !viewModel.authProviders.isEmpty {
                        emailSection
                    }
                }
            
            case .idle, .loaded:
                List {
                    if viewModel.authProviders.isEmpty {
                        Text("No data available.")
                    }
                    logOutButton
                    deleteAccountButton
                    if viewModel.authProviders.contains(.email) {
                        emailSection
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationBarTitle("Settings")
    }
    
    private func errorView(_ message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .padding()
    }
    
    private var logOutButton: some View {
        Button("Log out") {
            Task {
                await viewModel.signOut()
            }
        }
    }
    
    private var deleteAccountButton: some View {
        Button(role: .destructive) {
            Task {
                await viewModel.deleteAccount()
            }
        } label: {
            Text("Delete account")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(viewModel: SettingsViewModel(authenticationManager: MockAuthenticationManager(isSignedIn: false)))
        }
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    await viewModel.resetPassword()
                }
            }
            
            Button("Update password") {
                Task {
                    await viewModel.updatePassword()
                }
            }
            
            Button("Update email") {
                Task {
                    await viewModel.updateEmail()
                }
            }
        } header: {
            Text("Email functions")
        }
    }
    
    private var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    await viewModel.linkGoogleAccount()
                }
            }
            
            Button("Link Apple Account") {
                Task {
                    await viewModel.linkAppleAccount()
                }
            }
            
            Button("Link Email Account") {
                Task {
                    await viewModel.linkEmailAccount()
                }
            }
        } header: {
            Text("Create account")
        }
    }
}

