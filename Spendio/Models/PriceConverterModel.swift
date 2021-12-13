//
//  PriceConverterModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-12.
//

import Foundation

class PriceConverterModel {
    let settings = SettingsViewModel.shared
    let currencyAPI = CurrencyAPI()
    
    func fetchCurrencies() async throws {
        if let baseCurrency = settings.baseCurrency {
            try await currencyAPI.fetchCurrencies(baseCurrency: baseCurrency)
        }
    }
    
    func convert(expense: Expense) -> Double {
        if let currencies = currencyAPI.currency {
            if expense.currency != currencies.query.baseCurrency {
                if let data = currencies.data {
                    return expense.price / data["\(expense.currency!)"]!
                }
                
            }
            return expense.price
        }
        return expense.price
    }
    
    func modifyCurrencyLabel(expense: Expense) -> String? {
        if let baseCurrency = currencyAPI.currency?.query.baseCurrency {
            if expense.currency != baseCurrency {
                return baseCurrency
            }
            return expense.currency
        }
        return expense.currency
    }
}
