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
    var bitcoin: Int = 0
    var ethereum: Int = 0
    var solana: Int = 0
    
    var initials: String{
        return String(username.prefix(2)).uppercased()
    }
    
    
}


extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, email: "text@gmail.com", username: "tom00408")
}
