//
//  Wallet.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

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
    let iconName: String?
    
    var createdDate: Date {
        return Date(timeIntervalSince1970: _createdDate)
    }
    
    var icon: Image {
        guard let iconName = iconName else {
            return Image(systemName: "creditcard")
        }
        
        return Image(systemName: iconName)
    }
    
    var solde: Double {
        let totalSpent = self.spents?.reduce(0.0, { $0 + $1.amount }) ?? 0.0
        return self.amount - totalSpent
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
