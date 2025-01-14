import SwiftUI

struct CoinView: View {
    
    @StateObject var coinManager = CoinManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Hintergrundbild
                Image("livecharts")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                // Liste mit Coins
                List {
                    ForEach(coinManager.coins, id: \.self) { coin in
                        CoinRowView(coin: coin)
                    }
                }
                .navigationTitle("Live Prices")
                .navigationBarTitleDisplayMode(.inline) // Titel zentrieren
                .scrollContentBackground(.hidden) // Listenhintergrund transparent machen
            }
            
        }
    }
}


#Preview {
    CoinView()
}

