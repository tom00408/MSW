//
//  WalletCoinRowView.swift
//  MSW
//
//  Created by Tom Tiedtke on 27.12.24.
//

import SwiftUI

struct WalletCoinRowView: View {
    
    let coin : Coin
    let amount: Double
    
    var body: some View {
        HStack{
            AsyncImage(url: coin.imageUrl)
            
            Text(coin.name)
            
            VStack{
                Text("\(coin.currentPrice*amount)")
                Text("\(amount) \(coin.symbol)")
            }
        }
    }
}

#Preview {
    WalletCoinRowView(coin: Coin.sample, amount: 10)
}
