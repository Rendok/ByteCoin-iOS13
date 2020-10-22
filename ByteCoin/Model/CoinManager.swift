//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetExchangeRate(_ manager: CoinManager, exchageRate: Double);
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E1140505-4D97-4355-91B0-0620B2D7A09E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let dataPkg = data {
                    let decoder = JSONDecoder()
                    do {
                        let exchangeData = try decoder.decode(CoinData.self, from: dataPkg)
                        self.delegate?.didGetExchangeRate(self, exchageRate: exchangeData.rate)
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
        
    }
}
