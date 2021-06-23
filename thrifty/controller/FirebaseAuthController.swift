//
//  FirebaseAuthController.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import Foundation
import FirebaseAuth

class FirebaseAuthController {
    private(set) var isConnected: Bool
    
    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    init() {
        self.isConnected = Auth.auth().currentUser != nil
    }
    
    func signin(withEmail email: String, andPassword password: String) async throws -> User {
        do {
            let auth = Auth.auth()
            let authResult = try await auth.signIn(withEmail: email, password: password)
            
            return authResult.user
        }
        catch {
            throw catchFirAuthError(error)
        }
    }
    
    func signout() throws -> Void {
        try Auth.auth().signOut()
    }
    
    func register(withEmail email: String, andPassword password: String) async throws -> User {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return authResult.user
        }
        catch {
            throw catchFirAuthError(error)
        }
    }
    
    private func catchFirAuthError(_ error: Error) -> Error {
        guard let firErr = AuthErrorCode(rawValue: error._code) else {
            return NSError.defaultError(message: "Erreur inconnue, veuillez réessayer", domain: "Authentification", code: 0)
        }
        
        return NSError.defaultError(message: firErr.errorMessage, domain: "Authentification", code: 0)
    }
    
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .userDisabled:
            return "Utilisateur supprimer"
        case .operationNotAllowed:
            return "Opération interdite"
        case .emailAlreadyInUse:
            return "email déjà utiliser"
        case .invalidEmail:
            return "email incorect"
        case .wrongPassword:
            return "mot de passe incorect"
        case .tooManyRequests:
            return "Service indisponible, veuillez réessayer plus tard"
        case .userNotFound:
            return "utilisateur non trouvé"
        case .networkError:
            return "Impossible de ce connecter à internet"
        case .missingEmail:
            return "email non renseigner"
        case .missingPhoneNumber:
            return "télèphone non renseigner"
        case .invalidPhoneNumber:
            return "télèphone invalide"
        default:
            return "Erreur inconnue, veuillez réessayer"
        }
    }
}
