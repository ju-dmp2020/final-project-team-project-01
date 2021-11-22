//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    // Fetching currency rates from https://github.com/fawazahmed0/currency-api
    @Published var currencyRates: CurrencyRatesModel?
    @Published var currencyError: CurrencyAPIErrorModel? = nil
    
    // Date is set as a parameter in case it has to be used
    func fetch(baseCurrency: String, date: String = "latest") async {
        let jsonURL = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/\(date)/currencies/\(baseCurrency).json"
        
        guard let url = URL(string: jsonURL) else {
            self.currencyError = CurrencyAPIErrorModel(error: .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.currencyError = CurrencyAPIErrorModel(error: .badRequest)
                }
                return
            }
            
            // Decoder
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try jsonDecoder.decode(CurrencyRatesModel.self, from: data)
            DispatchQueue.main.async {
                self.currencyRates = decodedData
            }
        } catch {
            DispatchQueue.main.async {
                self.currencyError = CurrencyAPIErrorModel(error: .decode)
            }
        }
    }
}
