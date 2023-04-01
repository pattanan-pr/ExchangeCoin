//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FFF8128C-9289-4466-9E64-67C69FBFA883"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
          
          let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
          print(urlString)
          
          if let url = URL(string: urlString) {
              
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: url) { (data, response, error) in
                  if error != nil {
                      self.delegate?.didFailWithError(error: error!)
                      return
                  }
                  
                  if let safeData = data {
                      if let price = self.parseJSON(safeData) {
                          let priceStr = String(format: "%.2f", price)
                          print(priceStr)
                          self.delegate?.didUpdatePrice(price: priceStr, currency: currency)
                      }
                  }
              }
              task.resume()
          }
      }
    func parseJSON(_ data: Data) -> Double? {
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinData.self, from: data)
                let rateprice = decodedData.rate
                print(rateprice)
                return rateprice
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
        
}
