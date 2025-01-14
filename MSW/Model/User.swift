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
    var friendCode = ""
    
    
    var initials: String {
        return String(username.prefix(1)).uppercased()
    }
    
    func getId() -> String {
        return self.id
    }
    
    
    
}


extension User{
    static let TOM = User(id: "ABCDEFGLAKSJD", email: "Toms@troll.mail", username: "TomT", personalWallet: Wallet(id: UUID().uuidString, balance: 0, coins: ["BTC": 0.000853, "ETH" : 0.00859, "SOL": 10]))
    
    static let matte = User(
        id: "123RTOM",
        email: "Tom@tom.com",
        username: "matte",
        personalWallet: Wallet(id: "mattewallet", balance: 1000, coins: ["MATH":1])
        
        
    )
}
