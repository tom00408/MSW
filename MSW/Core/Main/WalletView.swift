//
//  WalletView.swift
//  MSW
//
//  Created by Tom Tiedtke on 18.12.24.
//

import SwiftUI

struct WalletView: View {
    
    @StateObject var coinManager = CoinManager()
    var user = User.TOM
    
    var body: some View {
        Text("HI")
    }
}

#Preview {
    WalletView()
}
