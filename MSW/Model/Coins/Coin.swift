//
//  Coin.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import Foundation

struct Coin: Codable, Hashable{
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    let priceChange24H, priceChangePercentage24H: Double
    let lastUpdated : String
    
    
    var readableTime: String {
        // ISO8601-Dateiformatter für die Eingabe
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Versuch, lastUpdated zu parsen
        if let date = isoFormatter.date(from: lastUpdated) {
            // Zielformatter für die Ausgabe
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "de_DE") // Deutsch
            outputFormatter.timeZone =  TimeZone(secondsFromGMT: 3600)
            outputFormatter.dateFormat = "HH:mm:ss" // Ziel-Format

            return outputFormatter.string(from: date)
        } else {
            return "Ungültiges Datum"
        }
    }
    
    
    var imageUrl: URL? {
        return URL(string: image)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case lastUpdated = "last_updated"
    }
}


extension Coin {
    static var sample = Coin(
        id: "Bitcoin", symbol: "BTC",
        name: "Bitcoin",
        image: "https://e7.pngegg.com/pngimages/145/494/png-clipart-gold-colored-bitcoin-coin-bitcoin-cryptocurrency-monero-initial-coin-offering-bitcoin-medal-gold-thumbnail.png",
        currentPrice: 16700,
        marketCapRank: 1,
        priceChange24H: 200,
        priceChangePercentage24H: 2.0,
        lastUpdated: "12 Uhr"
    )
    
    static var euro = Coin(
        id: "Euro", symbol: "EUR",
        name: "Euro",
        image: "https://e7.pngegg.com/pngimages/686/817/png-clipart-euro-euro.png",
        currentPrice: 1,
        marketCapRank: 0,
        priceChange24H: 0,
        priceChangePercentage24H: 0,
        lastUpdated: "12 Uhr"
    )
    
    static var math = Coin(
        id: "Math",
        symbol: "MATH",
        name: "Mathematics",
        image: "",
        currentPrice: 200,
        marketCapRank: 4,
        priceChange24H: 100.0,
        priceChangePercentage24H: 100,
        lastUpdated: "heute"
    )
        
        
}

