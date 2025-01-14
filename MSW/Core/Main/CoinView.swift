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
                            // NavigationLink für das Öffnen eines neuen Views
                            NavigationLink(destination: CoinDetailView(coin: coin)) {
                                CoinRowView(coin: coin)
                            }
                        }
                    }
                    //.navigationTitle("Live Prices")
                    .padding()
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarTitleDisplayMode(.inline) // Titel zentrieren
                    .scrollContentBackground(.hidden)
                    .frame(maxHeight: .infinity)
                    .opacity(0.8)// Listenhintergrund transparent machen
                    
                    
                
            }
        }
        
    }
}


#Preview {
    CoinView()
}

