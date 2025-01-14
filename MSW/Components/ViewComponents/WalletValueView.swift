//
//  WalletValueView.swift
//  MSW
//
//  Created by Tom Tiedtke on 11.01.25.
//

import SwiftUI

struct WalletValueView: View {
    @StateObject var coinManager = CoinManager()
    var user: User
    
    var wallet: Wallet {
        print(user.personalWallet.toString())
        return user.personalWallet
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Haupt-Box mit Benutzer- und Wallet-Informationen
            VStack(spacing: 16) {
                // Benutzerprofil
                HStack(spacing: 16) {
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.headline)
                            .fontWeight(.semibold)
                            //.foregroundColor(.black)
                        
                 /*       Text(user.email)
                            .font(.caption)
                            .foregroundColor(.gray)*/
                    }
                }
                
                Divider()
                
                // Wallet-Informationen
                VStack(spacing: 8) {
                    HStack {
                        Text("Total Value:")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(wallet.getValue(coinManager: coinManager).toCurrency())
                            .font(.title2)
                            .fontWeight(.bold)
                            //.foregroundColor(.black)
                    }
                    
                    HStack {
                        Text("24h Change:")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(wallet.get24hChangeValue(coinManager: coinManager).toCurrency())
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(
                                wallet
                                    .get24hChangeValue(
                                        coinManager: coinManager
                                    ) > 0 ? .green : .red
                            )
                    }
                    
                    HStack {
                        Text("24h % Change:")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(wallet.get24hChangePercentage(coinManager: coinManager).toPercentString())
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(
                                wallet
                                    .get24hChangeValue(
                                        coinManager: coinManager
                                    ) > 0 ? .green : .red
                            )
                    }
                }
            }
            .padding(16)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 4)
            
        }
        .padding()
        .background(Color(.clear))
    }
}

// Beispiel für die Vorschau
#Preview {
    WalletValueView(user: User.TOM)
}
