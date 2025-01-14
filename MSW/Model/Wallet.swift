//
//  Wallet.swift
//  MSW
//
//  Created by Tom Tiedtke on 26.12.24.
//

import Foundation

struct Wallet: Identifiable, Codable {
    let id: String
    var coins: [String: Double] // Kryptowährungen und ihre Mengen
    
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
            r.append(key)
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
    
    
    
    init(id: String = UUID().uuidString, balance: Double = 0.0, coins: [String: Double] = [:]) {
        self.id = id
        self.coins = coins
        self.coins["EUR"] = balance
    }
}


extension Wallet {
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

