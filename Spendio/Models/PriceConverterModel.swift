//
//  PriceConverterModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-12.
//

import Foundation

class PriceConverterModel {
    private let settings = SettingsViewModel.shared
    private let currencyAPI = CurrencyAPI()
    
    func fetchCurrencies() async throws {
        if let baseCurrency = settings.baseCurrency {
            try await currencyAPI.fetchCurrencies(baseCurrency: baseCurrency)
        }
    }
    
    func convert(expense: Expense) -> Double {
        if settings.baseCurrency != nil {
            if let currencies = currencyAPI.currency {
                if expense.currency != currencies.query.baseCurrency {
                    if let data = currencies.data?["\(expense.currency ?? "no crash")"] {
                        return expense.price / data
                    }
                    return expense.price
                }
                return expense.price
            }
            return expense.price
        }
        return expense.price
    }
    
    func modifyCurrencyLabel(expense: Expense) -> String? {
        if settings.baseCurrency != nil {
            if let baseCurrency = currencyAPI.currency?.query.baseCurrency {
                if expense.currency != baseCurrency {
                    return baseCurrency
                }
                return expense.currency
            }
            return expense.currency
        }
        return expense.currency
    }
}
