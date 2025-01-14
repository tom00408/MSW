import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WalletView()
                .tabItem{
                    Label("Wallet",systemImage: "wallet.bifold")
                }
            TradeView()
                .tabItem{
                    Label("Trade",systemImage: "arrow.up.arrow.down.square")
                }
            CoinView()
                .tabItem {
                    Label("Market", systemImage: "bitcoinsign.circle.fill")
                }
            FriendView()
                .tabItem{
                    Label("Freunde",systemImage: "person.2.fill")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
            
            
            
        }
    }
}


#Preview {
    ContentView()
}
