//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    // Fetching currency rates from https://github.com/fawazahmed0/currency-api
    @Published var currencies: CurrencyConverterModel?
    
    func fetch(baseCurrency: String, date: String = "latest") async {
        let jsonURL = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/\(date)/currencies/\(baseCurrency).json"
        
        guard let url = URL(string: jsonURL) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(URLError(.badServerResponse))
                throw URLError(.badServerResponse)
            }
            
            // Decoder
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try jsonDecoder.decode(CurrencyConverterModel.self, from: data)
            DispatchQueue.main.async {
                self.currencies = decodedData
            }
        } catch {
            print(error)
        }
        
    }
}
