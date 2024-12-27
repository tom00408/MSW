//
//  League.swift
//  MSW
//
//  Created by Tom Tiedtke on 27.12.24.
//

import Foundation

struct League: Codable , Identifiable{
    let id: String
    let name: String
    var member: [User]
    var wallets: [String: Wallet]
    let description: String
    
    let tag: String
    let code: String
}
