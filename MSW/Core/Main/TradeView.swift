//
//  TradeView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct TradeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var bitcoinAmount: Int = 0
    @State private var ethereumAmount: Int = 0
    @State private var solanaAmount: Int = 0

    var body: some View {
        if let user = viewModel.currentUser {
            VStack{
                Text("Crypto-Börse")
                    .font(.system(size: 64))
                    .bold()
                Image("trading_pinguin")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(100)
                    .padding(.vertical,32)
                VStack {
                    // Zeilen für jede Kryptowährung
                    DemoTradeCoinRow(coinName: "Bitcoin", amount: $bitcoinAmount)
                    DemoTradeCoinRow(coinName: "Ethereum", amount: $ethereumAmount)
                    DemoTradeCoinRow(coinName: "Solana", amount: $solanaAmount)
                    
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
                    // Initialisiere die Zustände, wenn die View geladen wird
                    bitcoinAmount = user.bitcoin
                    ethereumAmount = user.ethereum
                    solanaAmount = user.solana
                }
            }
        }
    }
    
    // Funktion zum Speichern der Änderungen
    private func saveChanges() async {
        guard let user = viewModel.currentUser else { return }
        
        do {
            try await viewModel.updateUserCryptos(
                userId: user.id,
                bitcoin: bitcoinAmount,
                ethereum: ethereumAmount,
                solana: solanaAmount
            )
            print("Kryptowerte erfolgreich aktualisiert!")
        } catch {
            print("Fehler beim Speichern der Kryptowerte: \(error.localizedDescription)")
        }
    }
}
