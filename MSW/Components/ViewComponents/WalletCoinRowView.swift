//
//  WalletCoinRowView.swift
//  MSW
//
//  Created by Tom Tiedtke on 27.12.24.
//
import Foundation
import SwiftUI

struct WalletCoinRowView: View {
    
    let coin: Coin
    let amount: Double
    

    
    var body: some View {
        HStack(spacing: 16) {
            // Coin Image
            AsyncImage(url: coin.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(16)
            } placeholder: {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 40, height: 40)
                    .cornerRadius(16)
            }
            
            // Coin Details
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                if coin.symbol != "EUR"{
                    Text(coin.priceChangePercentage24H.toPercentString())
                        .font(.caption)
                        .padding(.leading, 6)
                        .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
                }
            }
            
            Spacer()
            
            // Coin Amount and Value
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(String(format: "%.2f", coin.currentPrice * amount))€")
                    .font(.headline)
                    .foregroundColor(.green)
                if coin.symbol != "EUR"{
                    Text("\( amount.toAmountString()) \(coin.symbol.uppercased())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(1.0), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    WalletCoinRowView(coin: Coin.euro, amount: 10)
}
