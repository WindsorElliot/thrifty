//
//  UserViewModel.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import Foundation

class UserViewModel: ObservableObject {
    private let authController = FirebaseAuthController()
    
    @Published var isLoading: Bool = false
    @Published var isConnected: Bool = false
    @Published var error: Error? = nil {
        didSet {
            self.showError = error != nil
        }
    }
    @Published var showError: Bool = false
    
    
    init() {
        self.isLoading = true
        self.isConnected = self.authController.currentUser != nil
        self.isLoading = false
        self.error = nil
        self.showError = false
    }
    
    func connect(withEmail email: String, andPassword password: String) async {
        self.isLoading = true
        do{
            _ = try await self.authController.signin(withEmail: email, andPassword: password)
            self.isLoading = false
            self.isConnected = true
        }
        catch {
            self.isLoading = false
            self.error = error
        }
    }
    
    func register(withEmail email: String, andPassword password: String) async {
        self.isLoading = true
        do {
            let _ try await self.authController.register(withEmail: email, andPassword: password)
        }
        catch {
            self.error = error
        }
    }
}
