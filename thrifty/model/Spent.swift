//
//  Spent.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import Foundation

struct Spent: Codable {
    let name: String
    let comment: String?
    let _createdDate: Double
    let amount: Double
    
    var createdDate: Date {
        return Date(timeIntervalSince1970: _createdDate)
    }
    
    
}
