//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

// Fetching currency rates from https://freecurrencyapi.net/

class CurrencyViewModel: ObservableObject {
    let errorHandler = ErrorHandler.shared
    let apiKeyFileName = "apiKey"
    
    @Published var currency: CurrencyConverterModel?
    
    func fetchCurrencies(baseCurrency: String) async {
        let apiKey = self.loadApiKey(fileName: self.apiKeyFileName)["key"]
        let jsonURL = "https://freecurrencyapi.net/api/v2/latest?apikey=\(apiKey!)&base_currency=\(baseCurrency)"
        
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
    
    private func loadApiKey(fileName: String) -> [String : String] {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl, options: .alwaysMapped)
                let json = try! JSONSerialization.jsonObject(with: data) as! [String : String]
                return json
            }
        } catch {
            errorHandler.handle(error: CurrencyAPIError.key)
        }
        errorHandler.handle(error: CurrencyAPIError.key)
        return [:]
    }
}
