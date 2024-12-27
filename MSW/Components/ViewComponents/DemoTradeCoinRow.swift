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
    @Binding var amount: Int // Binding für die Anzahl
    
    var body: some View {
        HStack {
            Text(coinName)
            Spacer()
            
            Button {
                amount += 1 // Erhöhe die Anzahl
            } label: {
                Image(systemName: "plus")
            }
            
            Text("\(amount)")
            
            Button {
                amount -= 1 // Verringere die Anzahl
            } label: {
                Image(systemName: "minus")
            }
        }
        .padding()
    }
}

#Preview {
    DemoTradeCoinRow(coinName: "Bitcoin", amount: .constant(0))
}
