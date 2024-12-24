//
//  CoinView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject var coinManager = CoinManager()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(coinManager.coins, id:\.self) { coin in
                    CoinRowView(coin: coin)
                        
                }
            }.navigationTitle("Live Prices")
            
                
        }
    }

}


#Preview {
    CoinView()
}

