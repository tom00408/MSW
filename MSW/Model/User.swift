//
//  User.swift
//  loginFirebase
//
//  Created by Tom Tiedtke on 24.12.24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    var personalWallet: Wallet = Wallet()// Wird in Firebase gespeichert
    var currentWallet: Wallet? // Lokal verwaltet, nicht in Firebase gespeichert
    
    var initials: String {
        return String(username.prefix(2)).uppercased()
    }
    
    
    mutating func setCurrentWallet(_ wallet: Wallet) {
        currentWallet = wallet
    }
    mutating func usePersonalWallet() {
        currentWallet = personalWallet
    }
}


extension User{
    static let TOM = User(id: UUID().uuidString, email: "Toms@troll.mail", username: "T_o_m", personalWallet: Wallet(id: UUID().uuidString, balance: 1000, coins: ["BTC": 2, "ETH" : 4, "SOL": 10,"SHIB": 1000]), currentWallet: nil)
}
