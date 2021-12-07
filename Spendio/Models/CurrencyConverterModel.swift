//
//  CurrencyRatesModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-25.
//

import Foundation

struct CurrencyConverterModel: Decodable {
    
    struct Query: Decodable {
        let apikey: String
        let baseCurrency: String // 3 characters always
        let timestamp: Int
    }
    
    let query: Query
    let data: [String: Double]?
}
