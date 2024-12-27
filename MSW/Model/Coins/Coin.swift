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
        image: "",
        currentPrice: 16700,
        marketCapRank: 1,
        priceChange24H: 200,
        priceChangePercentage24H: 2.0,
        lastUpdated: "12 Uhr"
    )
}

