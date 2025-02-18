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
    var coins: [String : Double] = ["EUR":1000.0]
    var friendCode = ""
    
    
    var initials: String {
        return String(username.prefix(1)).uppercased()
    }
    
    func getId() -> String {
        return self.id
    }
    
    
    
}





//Wallet ohne Fetch funktionen
extension User{
    
    
    func getValue(coinManager: CoinManager)-> Double {
        print(coinManager.coins.count)
        var sum = 0.0
        for (symbol, amount) in coins {
            if let coin = coinManager.getCoinByString(symbol: symbol){
                sum += amount * coin.currentPrice
                //print("symbol: \(symbol), amount: \(amount), price: \(coin.currentPrice)")
            }else{
                sum -= 10000
                print("coin \(symbol) not found")
            }
        }
        return sum
    }
    
    
    
    func getOptionsForTrade()-> [String]{
        var r: [String] = ["EUR"]
        for(key,_) in coins{
            if key != "EUR"{
                r.append(key)
            }
        }
        return r
    }
    
    func toString()-> String{
        var r: String = ""
        for (key, value) in coins{
            r += "\(key): \(value)\n"
        }
        return r
    }
}


//Wallet Fetch Functionenn
extension User {
    // Berechnet die prozentuale 24-Stunden-Änderung des Wallet-Wertes
    func get24hChangePercentage(coinManager: CoinManager) -> Double {
        let currentValue = getValue(coinManager: coinManager)
        var previousValue = 0.0
        
        for (symbol, amount) in coins {
            if let coin = coinManager.getCoinByString(symbol: symbol) {
                let previousPrice = coin.currentPrice / (
                    1 + coin.priceChangePercentage24H / 100
                )
                previousValue += amount * previousPrice
            } else {
                print("Coin \(symbol) not found")
            }
        }
        
        if previousValue == 0 {
            return 0.0
        }
        
        let percentageChange = ((currentValue - previousValue) / previousValue) * 100
        return percentageChange
    }

    // Berechnet den absoluten Wert der 24-Stunden-Änderung des Wallet-Wertes
    func get24hChangeValue(coinManager: CoinManager) -> Double {
        let currentValue = getValue(coinManager: coinManager)
        var previousValue = 0.0
        
        for (symbol, amount) in coins {
            if let coin = coinManager.getCoinByString(symbol: symbol) {
                let previousPrice = coin.currentPrice / (
                    1 + coin.priceChangePercentage24H / 100
                )
                previousValue += amount * previousPrice
            } else {
                print("Coin \(symbol) not found")
            }
        }
        
        let valueChange = currentValue - previousValue
        return valueChange
    }
}






extension User{
    static let TOM = User(id: "ABCDEFGLAKSJD", email: "Toms@troll.mail", username: "TomT", coins: ["BTC": 0.000853, "ETH" : 0.00859, "SOL": 10])
    
    static let matte = User(
        id: "123RTOM",
        email: "Tom@tom.com",
        username: "matte",
        coins: ["MATH":1])
        
        
    
}
