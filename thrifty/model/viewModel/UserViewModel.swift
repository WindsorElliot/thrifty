//
//  UserViewModel.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum LoginState {
    case loading
    case login
    case register
    case connected(context: AppContext)
}

class UserViewModel: ObservableObject {
    private let authController = FirebaseAuthController()
    
    @Published var state: LoginState = .loading
    
    @Published var error: Error? = nil {
        didSet {
            self.showError = error != nil
        }
    }
    @Published var showError: Bool = false
    
    
    init() {
        if self.authController.currentUser != nil {
            self.state = .connected(context: AppContext())
        }
        else {
            self.state = .login
        }
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil  {
                self.state = .login
            }
        }
    }
    
    func handleTapRegister() {
        self.state = .register
    }
    
    func connect(withEmail email: String, andPassword password: String) async {
        self.state = .loading
        do{
            _ = try await self.authController.signin(withEmail: email, andPassword: password)
            self.state = .connected(context: AppContext())
        }
        catch {
            self.state = .login
            self.error = error
        }
    }
    
    func register(withEmail email: String, andPassword password: String) async {
        self.state = .loading
        do {
            let user = try await self.authController.register(withEmail: email, andPassword: password)
            try await Firestore.firestore().collection("users").document(user.uid).setData(["createdDate": Date().timeIntervalSince1970])
            self.state = .connected(context: AppContext())
        }
        catch {
            self.state = .login
            self.error = error
        }
    }
}
