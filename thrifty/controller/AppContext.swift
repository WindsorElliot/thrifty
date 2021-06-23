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

class AppContext {
    static let shared: AppContext = AppContext()
    
    let user: User
    let store: Firestore
    
    init() {
        self.user = Auth.auth().currentUser!
        self.store = Firestore.firestore()
    }
    
}

protocol WalletContextProtocol {
    func createWallet(name: String, amout: Double, type: WalletCountType) async throws -> Wallet
    func updateWallet(_ wallet: Wallet, withName name: String?, amount: Double?, type: WalletCountType?) async throws -> Wallet
    func deleteWallet(id: String) async throws -> Void
}
