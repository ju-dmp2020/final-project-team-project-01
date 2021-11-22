//
//  CurrencyConverterModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

struct CurrencyConverterModel: Decodable {
    let date: String
    let sek: [String: Double] // keys are dynamic, will be handled later
}
