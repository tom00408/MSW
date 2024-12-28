//
//  DemoTradeCoinRow.swift
//  MSW
//
//  Created by Tom Tiedtke on 27.12.24.
//

import Foundation
import SwiftUI

struct DemoTradeCoinRow: View {
    let coinName: String
    @Binding var amount: Double // Binding für die Coin-Menge
    
    var body: some View {
        HStack {
            Text(coinName)
            Spacer()
            
            Button {
                amount += 1 // Erhöhe die Menge
            } label: {
                Image(systemName: "plus")
            }
            
            Text("\(amount, specifier: "%.2f")") // Zeigt die Menge mit 2 Dezimalstellen an
            
            Button {
                if amount > 0 { amount -= 1 } // Verhindere negative Werte
            } label: {
                Image(systemName: "minus")
            }
        }
        .padding()
    }
}

#Preview {
    DemoTradeCoinRow(coinName: "Bitcoin", amount: .constant(0.5))
}

