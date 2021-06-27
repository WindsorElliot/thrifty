//
//  AppContext.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

typealias AppContextProtocol = WalletContextProtocol

enum ContextType {
    case preview
    case normal
}

class AppContext {
    static let shared: AppContext = AppContext()
    
    let type: ContextType
    let user: User?
    let store: Firestore?
    
    init(type: ContextType = .normal) {
        self.type = type
        switch self.type {
        case .normal:
            self.user = Auth.auth().currentUser!
            self.store = Firestore.firestore()
        case .preview:
            self.user = nil
            self.store = nil
        }
    }
    
}

protocol WalletContextProtocol {
    func createWallet(name: String, amout: Double, type: WalletCountType) async throws -> Wallet
    func updateWallet(_ wallet: Wallet, withName name: String?, amount: Double?, type: WalletCountType?) async throws -> Wallet
    func deleteWallet(id: String) async throws -> Void
}
