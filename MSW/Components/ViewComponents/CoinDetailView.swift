//
//  CoinDetailView.swift
//  MSW
//
//  Created by Tom Tiedtke on 14.01.25.
//

import SwiftUI

struct CoinDetailView: View {
    let coin: Coin
    var body: some View {
        VStack{
            CoinRowView(coin: coin)
                
        }
    }
}

#Preview {
    CoinDetailView(coin: Coin.euro)
}
