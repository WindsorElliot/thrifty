//
//  WalletViewModel+AppContext.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import Foundation
import FirebaseFirestore

class WalletViewModel: ObservableObject {
    private let context: AppContext
    
    @Published var wallets: [Wallet] = []
    public var error: Error?
    
    init(context: AppContext = AppContext.shared) {
        self.context = context
        if context.type == .normal, let uid = self.context.user?.uid {
            self.context.store?.collection("users").document(uid).collection(kCollectionName).addSnapshotListener { query, error in
                if let err = error {
                    print(err)
                    return
                }
                query?.documentChanges.forEach({ change in
                    switch change.type {
                    case .added:
                        self.handleAddDocumentFromBdd(change.document)
                    case .modified:
                        self.handleUpdateDocumentFromBdd(change.document)
                    case .removed:
                        self.handleDeleteDocumentFromBdd(change.document)
                    }
                })
            }
        }
        else {
            self.stubsContext()
        }
    }
}

extension WalletViewModel: BaseFirViewModel {
    var kCollectionName: String {
        return "wallets"
    }
    
    func collection() throws -> CollectionReference  {
        guard
            let store = self.context.store,
            let uid = self.context.user?.uid
        else {
            throw NSError.defaultError(message: "Error context not initialized", domain: "Auth", code: 0)
        }
                
        return store.collection("users").document(uid).collection(kCollectionName)
    }
    
    internal func handleAddDocumentFromBdd(_ documenSnashot: DocumentSnapshot) {
        do {
            guard let wallet = try documenSnashot.data(as: Wallet.self) else {
                return
            }
            self.wallets.append(wallet)
        }
        catch {
            self.error = retriveFirStoreError(error)
        }
    }
    
    internal func handleUpdateDocumentFromBdd(_ documenSnapshot: DocumentSnapshot) {
        do {
            guard let wallet = try documenSnapshot.data(as: Wallet.self) else {
                return
            }
            
            guard let walletIndex = self.wallets.firstIndex(where: { $0.id == wallet.id }) else {
                return
            }
            
            self.wallets[walletIndex] = wallet
        }
        catch {
            self.error = retriveFirStoreError(error)
        }
    }
    
    internal func handleDeleteDocumentFromBdd(_ docuementSnapshot: DocumentSnapshot) {
        do {
            guard let wallet = try docuementSnapshot.data(as: Wallet.self) else {
                return
            }
            
            guard let walletIndex = self.wallets.firstIndex(where: { $0.id == wallet.id }) else {
                return
            }
            
            self.wallets.remove(at: walletIndex)
        }
        catch {
            self.error = retriveFirStoreError(error)
        }
    }
}

extension WalletViewModel {
    func stubsContext() {
        let wallet: Wallet = Wallet(id: UUID().uuidString, name: "Amex", _createdDate: Date().timeIntervalSince1970, spents: nil, type: .week, amount: 50, iconName: nil)
        
        self.wallets.append(wallet)
        
        let wallet2: Wallet = Wallet(id: UUID().uuidString, name: "Gold", _createdDate: Date().timeIntervalSince1970, spents: nil, type: .week, amount: 100, iconName: nil)
        
        self.wallets.append(wallet2)
    }
}

extension WalletViewModel: AppContextProtocol {
    func createWallet(name: String, amout: Double, type: WalletCountType) async throws -> Wallet {
        let walletToCreate = Wallet(id: nil, name: name, _createdDate: Date().timeIntervalSince1970, spents: nil, type: type, amount: amout, iconName: nil)
        do {
            let doc = try self.collection().addDocument(from: walletToCreate)
            if let wallet = try await doc.getDocument().data(as: Wallet.self) {
                return wallet
            }
            
            throw NSError.defaultError(message: "Une erreur inconue c'est produite", domain: "Wallet", code: 0)
            
        }
        catch {
            throw retriveFirStoreError(error)
        }
    }
    
    func updateWallet(_ wallet: Wallet, withName name: String?, amount: Double?, type: WalletCountType?) async throws -> Wallet {
        do {
            let walletForUpdate = Wallet(
                id: wallet.id,
                name: name ?? wallet.name,
                _createdDate: wallet._createdDate,
                spents: wallet.spents,
                type: type ?? wallet.type,
                amount: amount ?? wallet.amount,
                iconName: nil
            )
            
            guard let id = walletForUpdate.id else {
                throw NSError.defaultError(message: "Une erreur inconue c'est produite", domain: "Wallet", code: 0)
            }
            try self.collection().document(id).setData(from: walletForUpdate)
            
            return walletForUpdate
        }
        catch {
            throw retriveFirStoreError(error)
        }
    }
    
    func deleteWallet(id: String) async throws {
        do {
            try await self.collection().document(id).delete()
        }
        catch {
            throw retriveFirStoreError(error)
        }
    }
    
    private func retriveFirStoreError(_ error: Error) -> Error {
        guard let firErr = FirestoreErrorCode(rawValue: error._code) else {
            return error
        }
        
        switch firErr {
        case .OK:
            return NSError.defaultError(message: "Aucune erreur", domain: "Wallet", code: 0)
        case .cancelled:
            return NSError.defaultError(message: "Op??ration annul??e", domain: "Wallet", code: 0)
        case .unknown:
            return NSError.defaultError(message: "Erreur inconnue", domain: "Wallet", code: 0)
        case .invalidArgument:
            return NSError.defaultError(message: "Argument invalide", domain: "Wallet", code: 0)
        case .deadlineExceeded:
            return NSError.defaultError(message: "Op??ration trop long", domain: "Wallet", code: 0)
        case .notFound:
            return NSError.defaultError(message: "Document non trouver", domain: "Wallet", code: 0)
        case .alreadyExists:
            return NSError.defaultError(message: "Document d??j?? existant", domain: "Wallet", code: 0)
        case .permissionDenied:
            return NSError.defaultError(message: "acc??s ?? la ressource interdit", domain: "Wallet", code: 0)
        default:
            return NSError.defaultError(message: "Une erreur inconue c'est produite", domain: "Wallet", code: 0)
        }
    }
    
    
}
