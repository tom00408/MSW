//
//  TradeView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct TradeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var coinAmounts: [String: Double] = [:] // Lokaler Zustand für Coins und ihre Mengen

    var body: some View {
        if let user = viewModel.currentUser {
            VStack{
                Text("Crypto-Börse")
                    .font(.system(size: 64))
                    .bold()
                
                Image("trading_pinguin")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(150)
                    .padding(.vertical,32)
                VStack {
                    // Dynamisch eine Zeile für jeden Coin erstellen
                    ForEach(Array(coinAmounts.keys), id: \.self) { coinName in
                        if let amount = coinAmounts[coinName] {
                            DemoTradeCoinRow(coinName: coinName, amount: Binding(
                                get: { amount },
                                set: { newValue in coinAmounts[coinName] = newValue }
                            ))
                        }
                    }
                    
                    // Speichern-Button
                    Button {
                        Task {
                            await saveChanges()
                        }
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                }
                .padding()
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .cornerRadius(10)
                .onAppear {
                    // Initialisiere die Coins aus dem personalWallet
                    coinAmounts = user.personalWallet.coins
                }
            }
        }
    }
    
    // Speichert die Änderungen in Firebase
    private func saveChanges() async {
        guard let user = viewModel.currentUser else { return }
        
        var updatedWallet = user.personalWallet
        updatedWallet.coins = coinAmounts // Aktualisierte Coins
        
        do {
            try await viewModel.updatePersonalWallet(userId: user.id, wallet: updatedWallet)
            print("Wallet erfolgreich aktualisiert!")
        } catch {
            print("Fehler beim Speichern der Coins: \(error.localizedDescription)")
        }
    }
}

