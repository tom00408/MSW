//
//  Wallet.swift
//  MSW
//
//  Created by Tom Tiedtke on 26.12.24.
//

import Foundation

struct Wallet: Identifiable, Codable {
    let id: String
    var balance: Double
    var coins: [String: Double] // Kryptowährungen und ihre Mengen
    
    init(id: String = UUID().uuidString, balance: Double = 0.0, coins: [String: Double] = [:]) {
        self.id = id
        self.balance = balance
        self.coins = coins
        self.coins["bitcoins"] = 19
        self.coins["ethereum"] = 10
        self.coins["litecoin"] = 1
    }
}


 
