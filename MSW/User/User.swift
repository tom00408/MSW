//
//  User.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import Foundation


class User{
    let id: Int
    var name: String
    
    var balance: Double
    
    
    init(){
        id = Int.random(in: 1...1000)
        name = "User \(id)"
        balance = 1000
    }
    
    
    func getName() -> String{
        return self.name
    }
}
