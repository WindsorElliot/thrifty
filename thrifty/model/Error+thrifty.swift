//
//  Error+thrifty.swift
//  thrifty
//
//  Created by Elliot Cunningham on 22/06/2021.
//

import Foundation

extension NSError {
    static func defaultError(message: String, domain: String, code: Int) -> Error {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: message]) as Error
    }
}
