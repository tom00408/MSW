//
//  TradeOptionView.swift
//  MSW
//
//  Created by Tom Tiedtke on 09.01.25.
//

import SwiftUI

struct TradeOptionView: View {
    let coin: Coin
    
    var body: some View {
        HStack{
            AsyncImage(url: coin.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.orange)
                    .cornerRadius(16)
            } placeholder: {
                Circle()
                    .frame(width: 32, height: 32)
                    .background(Color(.systemGray5))
                    
            }
            Text(coin.symbol.uppercased())
                
            
        }
    }
}

#Preview {
    TradeOptionView(coin: Coin.euro)
}
