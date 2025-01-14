//
//  TradeView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI
import Foundation

struct TradeView: View {
    
    @StateObject var coinManager = CoinManager()
    //@EnvironmentObject var viewModel : AuthViewModel
    var user = User.TOM
    
    @State private var selectedOption1 = "EUR"
    @State private var selectedOption2 = "EUR"
    
    @State private var selectedOptionsPrice1 = 1.0
    @State private var selectedOptionsPrice2 = 1.0
    
    @State private var amount1 = 0.0
    @State private var amount2 = 0.0
    
    
    @State private var isExpanded1 = false
    @State private var isExpanded2 = false
    
    @FocusState private var isInputFocused1: Bool
    @FocusState private var isInputFocused2: Bool
    
    var tradeIsValid: Bool {
        return selectedOption1 != selectedOption2
        && selectedOption1 != ""
        && selectedOption2 != ""
        && amount1 != 0
        && amount2 != 0
    }
        
  
    
    var body: some View {

        ZStack { // ZStack, um Dropdowns zu überlagern
            Image("trade")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.29)
                .ignoresSafeArea()
                .opacity(0.5)
            //if let user = viewModel.currentUser {
            if true{
                VStack { // Hauptinhalt bleibt im VStack
                    
                    HStack {
                        // DROPDOWN 1 - eigene Resourcen
                        VStack {
                            Button(action: {
                                isExpanded1.toggle() // Dropdown ein/ausklappen
                                if isExpanded2 { isExpanded2 = false } // Nur ein Dropdown geöffnet
                            }) {
                                HStack {
                                    if let coin = coinManager.getCoinByString(
                                        symbol: selectedOption1
                                    ){
                                        TradeOptionView(coin: coin)
                                            .foregroundColor(.red)
                                    }
                                    
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.red)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                            Spacer()
                                .frame(height: 20)
                            HStack{
                                TextField(
                                    "Anzahl",
                                    text: Binding(
                                        get: {
                                            // Konvertiere Double zu String
                                            String(amount1)
                                        },
                                        set: { newValue in
                                            // Konvertiere String zu Double, falls möglich
                                            if let value = Double(newValue) {
                                                amount1 = value
                                                amount2 = (
                                                    amount1 * selectedOptionsPrice1
                                                )/selectedOptionsPrice2
                                            }
                                        }
                                    )
                                )
                                .keyboardType(.decimalPad) // Zeigt eine numerische Tastatur
                                .focused($isInputFocused1)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                //.padding()
                                Spacer()
                                Button {
                                    isInputFocused1 = false // Tastatur schließen
                                } label: {
                                    Image(systemName: "checkmark.circle") // Symbolname als String
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }.padding(.bottom, 10)
                                
                        }
                        .zIndex(isExpanded1 ? 1 : 0) // Sicherstellen, dass Dropdown 1 im Vordergrund bleibt
                        
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            VStack {
                                if isExpanded1 {
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            ForEach(
                                                user.personalWallet
                                                    .getOptionsForTrade(),
                                                id: \.self
                                            ) { option in
                                                if let coin = coinManager.getCoinByString(
                                                    symbol: option) {
                                                    if(coin.symbol != "EUR"){
                                                        
                                                        TradeOptionView(coin:coin)
                                                            .padding()
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            //.background(Color.white)
                                                            .onTapGesture {
                                                                selectedOption1 = option
                                                                if let price = coinManager.getCoinByString(
                                                                    symbol: option)?.currentPrice{
                                                                    selectedOptionsPrice1 = price
                                                                }
                                                                amount2 = (amount1*selectedOptionsPrice1)/selectedOptionsPrice2
                                                                
                                                                isExpanded1 = false // Dropdown schließen
                                                            }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    .frame(height: 200)
                                    // Begrenzte Höhe für 5 Einträge (ca. 40px pro Eintrag)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .shadow(radius: 5)
                                }
                            }
                                .padding(.top, 50) // Dropdown direkt unter dem Button
                                .zIndex(1)
                        )
                        
                        // Pfeil zwischen beiden Dropdowns
                        Image(systemName: "arrowshape.right.circle.fill")
                            .font(.system(size: 20))
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                        
                        // DROPDOWN 2 - optionale Coins
                        VStack {
                            Button(action: {
                                isExpanded2.toggle() // Dropdown ein/ausklappen
                                if isExpanded1 { isExpanded1 = false } // Nur ein Dropdown geöffnet
                            }) {
                                HStack {
                                    if let coin = coinManager.getCoinByString(
                                        symbol: selectedOption2
                                    ){
                                        TradeOptionView(coin: coin)
                                            //.foregroundColor(.red)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        //.foregroundColor(.red)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                            Spacer()
                                .frame(height: 20)
                            HStack{
                                TextField("Anzahl", text: Binding(
                                    get: {
                                        // Konvertiere Double zu String
                                        String(amount2)
                                    },
                                    set: { newValue in
                                        // Konvertiere String zu Double, falls möglich
                                        if let value = Double(newValue) {
                                            amount2 = value
                                            amount1 = (amount2 * selectedOptionsPrice2)/selectedOptionsPrice1
                                            
                                        }
                                    }
                                ))
                                .keyboardType(.decimalPad) // Zeigt eine numerische Tastatur
                                .focused($isInputFocused2)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Spacer()
                                Button {
                                    isInputFocused2 = false // Tastatur schließen
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        //.foregroundColor(.red)// Symbolname als String
                                }
                                Spacer()
                            }.padding(.bottom,10)
                        }
                        .zIndex(isExpanded2 ? 1 : 0) // Sicherstellen, dass Dropdown 2 im Vordergrund bleibt
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            VStack {
                                if isExpanded2 {
                                    ScrollView {
                                        VStack(spacing: 0) {
                                            ForEach(coinManager.getOptionsForTrade(), id: \.self) { option in
                                                if let coin = coinManager.getCoinByString(
                                                    symbol: option) {
                                                    
                                                    TradeOptionView(coin:coin)
                                                        .padding()
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        //.background(Color.white)
                                                        .onTapGesture {
                                                            selectedOption2 = option
                                                            if let price = coinManager.getCoinByString(
                                                                symbol: option)?.currentPrice{
                                                                selectedOptionsPrice2 = price
                                                            }
                                                            amount2 = (amount1*selectedOptionsPrice1)/selectedOptionsPrice2
                                                            isExpanded2 = false // Dropdown schließen
                                                        }
                                                }
                                                
                                            }
                                        }
                                    }
                                    .frame(height: 400) // Begrenzte Höhe für 5 Einträge (ca. 40px pro Eintrag)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .shadow(radius: 5)
                                }
                            }
                                .padding(.top, 50)
                                .zIndex(1)
                        )
                    }
                    .padding()
                    
                    //Alle Infos zum Trade
                    VStack{
                        Text("Trade-Summary")
                        Rectangle()
                            .frame(width: 300, height: 1)
                            .foregroundColor(Color(.black))
                        
                        Text(
                            "\(selectedOption1): \(amount1.toAmountString())"
                        )
                        HStack{
                            Text((amount1*selectedOptionsPrice1).toCurrency())
                                .opacity(0)
                            Image(systemName: "arrowshape.down.circle")
                            Text((amount1*selectedOptionsPrice1).toCurrency())
                        }
                        Text(
                            "\(selectedOption2): \(amount2.toAmountString())"
                        )
                        Rectangle()
                            .frame(width: 300, height: 1)
                            .foregroundColor(Color(.black))
                        
                        Text("Das ist ein guter Trade")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .zIndex(-1)
                    
                    
                    
                    
                    // Confirm-Button
                    Button {
                        Task {
                            try await makeTrade(user: user)
                        }
                    } label: {
                        HStack {
                            Text("Confirm Trade")
                            Image(systemName: "checkmark.shield")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!tradeIsValid                    )
                    .opacity(tradeIsValid ? 1 : 0.5)
                    .cornerRadius(10)
                    .zIndex(-1)
                }
            }
            }
                .background(Color(.systemBackground))
                .edgesIgnoringSafeArea(.all)
        
    }
    
    func makeTrade(user: User) async {
        // Referenz auf das Wallet
        var wallet = user.personalWallet
        
        // Prüfen, ob die erste Option existiert und genug Guthaben vorhanden ist
        guard let currentAmount1 = wallet.coins[selectedOption1], currentAmount1 >= amount1 else {
            print("Selected Option 1 not found in Wallet or insufficient balance")
            return
        }
        
        // Guthaben anpassen
        wallet.coins[selectedOption1] = currentAmount1 - amount1
        
        // Prüfen, ob der hinzuzufügende Coin existiert
        if let currentAmount2 = wallet.coins[selectedOption2] {
            wallet.coins[selectedOption2] = currentAmount2 + amount2
        } else {
            // Wenn der Coin noch nicht existiert, wird er mit dem Betrag hinzugefügt
            wallet.coins[selectedOption2] = amount2
        }
        
        // Änderungen in Firebase hochladen
        do {
            //try await viewModel.updatePersonalWallet(userId: user.id, wallet: wallet)
            print("Trade erfolgreich durchgeführt: \(amount1) \(selectedOption1) gegen \(amount2) \(selectedOption2)")
        } catch {
            print("Fehler beim Hochladen des Wallets: \(error.localizedDescription)")
        }
    }



    
}

#Preview {
    TradeView()
}
