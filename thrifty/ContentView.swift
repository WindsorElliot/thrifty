//
//  ContentView.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    
    
    var body: some View {
        Group {
            switch self.userViewModel.state {
            case .loading:
                LoaderSwiftUIView()
            case .login:
                LoginSwiftUIView(handleTapConnectButton: { (email, password) in
                    self.handleTapConnectButon(email: email, password: password)
                }, handleTapRegisterButton: {
                    self.handleTapRegiterButoon()
                })
            case .register:
                RegisterSwiftUIView { email, password in
                    self.handleTapCreateAccount(email: email, password: password)
                } handleTapBackButton: {
                    self.userViewModel.state = .login
                }

            case .connected:
                HomeSwiftUIView()
            }
        }
        .alert(isPresented: self.$userViewModel.showError) {
            Alert(title: Text("Error"), message: Text(self.userViewModel.error?.localizedDescription ?? "Erreur inconue"), dismissButton: .cancel())
        }
    }
    
    
    private func handleTapRegiterButoon() {
        self.userViewModel.handleTapRegister()
    }
    
    private func handleTapConnectButon(email: String, password: String) {
        async {
            await self.userViewModel.connect(withEmail: email, andPassword: password)
        }
    }
    
    private func handleTapCreateAccount(email: String, password: String) {
        async {
            await self.userViewModel.register(withEmail: email, andPassword: password)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
