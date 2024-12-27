//
//  Wallet.swift
//  MSW
//
//  Created by Tom Tiedtke on 26.12.24.
//

import Foundation

struct Wallet : Identifiable, Codable{
    let id: String
    var balance : Double
    var coins : [String: Double]
    
    
    func networth() -> Double{
        return balance
    }
    
}

 
