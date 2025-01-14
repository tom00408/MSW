//
//  WalletView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct WalletView: View {
    
    @StateObject var coinManager = CoinManager()
    //@EnvironmentObject var viewModel: AuthViewModel
    var user = User.TOM
    
    
    var body: some View {
        //if let user = viewModel.currentUser {
        if true{
            ZStack{
                Image("wallet")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .opacity(0.5)
                
                VStack{
                    
                    
                    WalletValueView(user: user)
                        .padding()
                        
                    
                    
                    if let coin = coinManager.getCoinByString(symbol: "EUR"), let balance = user.personalWallet.coins["EUR"]{
                        WalletCoinRowView(coin: coin, amount: balance)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                    }else{
                        Text("Unkown Coin : EUR")
                    }
                    ScrollView {
                        ForEach(user.personalWallet.coins.keys.sorted(), id: \.self) { key in
                            if key != "EUR"{
                                if let coin = coinManager.getCoinByString(symbol: key),
                                   let amount = user.personalWallet.coins[key] {
                                    WalletCoinRowView(coin: coin, amount: amount)
                                        .padding(.horizontal, 30)
                                }else{
                                    HStack{
                                        Text("\(key)")
                                        Text("\(user.personalWallet.coins[key] ?? 0)")
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal,20)
                }
            }
        }
         
       
    }
}

#Preview {
    WalletView()
}
