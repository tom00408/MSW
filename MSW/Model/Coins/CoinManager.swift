import Foundation


/*
 Chart Curl:
 
 curl -s 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=eur&days=1' -H 'accept: application/json'

 
 
 */

class CoinManager: ObservableObject {
    @Published var coins = [Coin]()

    
    let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    
    var urlString: String {
        //return  "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"
        return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=50&page=1&price_change_percentage=24h"

    }
    
    init() {
        print("fetching coins")
        fetchCoinsWithURLSession()
    }
    
    
    func getCoinByString(symbol: String) -> Coin? {
        if symbol == "EUR"{
            return Coin.euro
        }
        if symbol == "MATH"{
            return Coin.math
        }
    
        for coin in coins {
            if coin.symbol.uppercased() == symbol.uppercased() {
                return coin
            }
        }
        return nil
    }
    
    
    func getOptionsForTrade()->[String]{
        var r : [String] = ["EUR"]
        for coin in coins{
            r.append(coin.symbol.uppercased())
        }
        return r
    }
    
}

// MARK: - URLSession

extension CoinManager {
    func fetchCoinsWithURLSession() {
        guard let url = URL(string: urlString) else {
            print("DEBUG: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
                        
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Error \(error)")
                    return
                }
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("DEBUG: Server error")
                    return
                }
                
                guard let data = data else {
                    print("DEBUG: Invalid data")
                    return
                }
                
                guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                    print("DEBUG: Invalid data")
                    return
                }
                //print(String(decoding: data, as: UTF8.self))
                self.coins = coins
            }
        }.resume()
    }
    
    
}


