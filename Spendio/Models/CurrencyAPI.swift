//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

// Fetching currency rates from https://freecurrencyapi.net/

class CurrencyAPI: ObservableObject {
    let apiKeyFileName = "apiKey"
    
    @Published var currency: CurrencyConverterModel?
    
    func fetchCurrencies(baseCurrency: String) async throws {
        let key = try self.loadAPIKey(fileName: self.apiKeyFileName)["key"]
        let jsonURL = "https://freecurrencyapi.net/api/v2/latest?apikey=\(key!)&base_currency=\(baseCurrency)"
        
        guard let url = URL(string: jsonURL) else {
            throw CurrencyAPIError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw CurrencyAPIError.badRequest
            }
            
            // Decoder
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try jsonDecoder.decode(CurrencyConverterModel.self, from: data)
            DispatchQueue.main.async {
                self.currency = decodedData
            }
        } catch {
            throw CurrencyAPIError.decode
        }
    }
    
    private func loadAPIKey(fileName: String) throws -> [String : String] {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl, options: .alwaysMapped)
                let json = try! JSONSerialization.jsonObject(with: data) as! [String : String]
                return json
            }
            throw CurrencyAPIError.key
        } catch {
            throw CurrencyAPIError.key
        }
    }
}
