//
//  CurrencyViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation


enum CurrencyAPIError: Error {
    case invalidURL, badRequest, decode
}

class CurrencyViewModel: ObservableObject {
    // Fetching currency rates from https://github.com/fawazahmed0/currency-api
    @Published var currencyRates: CurrencyRatesModel?
    
    // Date is set as a parameter in case it has to be used
    func fetch(baseCurrency: String, date: String = "latest") async throws {
        let jsonURL = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/\(date)/currencies/\(baseCurrency).json"
        
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
            
            let decodedData = try jsonDecoder.decode(CurrencyRatesModel.self, from: data)
            DispatchQueue.main.async {
                self.currencyRates = decodedData
            }
        } catch {
            throw CurrencyAPIError.decode
        }
    }
}

extension CurrencyAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .badRequest:
            return NSLocalizedString("Currency rate data couldn't be recieved", comment: "")
        case .decode:
            return NSLocalizedString("Currency rate data couldn't be decoded", comment: "")
        }
    }
}
