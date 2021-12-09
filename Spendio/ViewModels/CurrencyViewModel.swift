//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

// Fetching currency rates from https://freecurrencyapi.net/

class CurrencyViewModel: ObservableObject {
    
    @Published var currency: CurrencyConverterModel?
    
    let errorHandler = ErrorHandler.shared
    
    private var apiKey = "c9ff9520-4e00-11ec-8ed5-856ceff69779" // Will be replaced somewhere else
    
    func fetch(baseCurrency: String) async {
        let jsonURL = "https://freecurrencyapi.net/api/v2/latest?apikey=\(apiKey)&base_currency=\(baseCurrency)"
        
        guard let url = URL(string: jsonURL) else {
            errorHandler.handle(error: CurrencyAPIError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                errorHandler.handle(error: CurrencyAPIError.badRequest)
                return
            }
            
            // Decoder
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try jsonDecoder.decode(CurrencyConverterModel.self, from: data)
            DispatchQueue.main.async {
                self.currency = decodedData
                print(decodedData)
            }
        } catch {
            errorHandler.handle(error: CurrencyAPIError.decode)
        }
    }
}
