//
//  Wallet.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import Foundation
import FirebaseFirestoreSwift

enum WalletCountType: Int, Codable, CaseIterable{
    case week = 0
    case month = 1
    case years = 2
}

struct Wallet: Codable {
    @DocumentID var id: String?
    let name: String
    let _createdDate: Double
    let spents: [Spent]?
    let type: WalletCountType
    let amount: Double
    
    var createdDate: Date {
        return Date(timeIntervalSince1970: _createdDate)
    }
}

extension WalletCountType {
    var descriptionName: String {
        switch self {
        case .week:
            return "semaine"
        case .month:
            return "mois"
        case .years:
            return "years"
        }
    }
    
    
}
