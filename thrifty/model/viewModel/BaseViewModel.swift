//
//  BaseViewModel.swift
//  thrifty
//
//  Created by Elliot Cunningham on 23/06/2021.
//

import Foundation
import FirebaseFirestore


protocol BaseFirViewModel {
    var kCollectionName: String { get }
    
    var collection: CollectionReference { get }
    
    func handleAddDocumentFromBdd(_ documenSnashot: DocumentSnapshot)
    
    func handleUpdateDocumentFromBdd(_ documenSnapshot: DocumentSnapshot)
    
    func handleDeleteDocumentFromBdd(_ docuementSnapshot: DocumentSnapshot)
}
