//
//  PriceConverterModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-12.
//

import Foundation

class PriceConverterModel {
    let settings = SettingsViewModel.shared
    let currencies = CurrencyViewModel()
    
    func fetchCurrencies() async {
        if let baseCurrency = settings.baseCurrency {
            await currencies.fetchCurrencies(baseCurrency: baseCurrency)
        }
    }
    
    func convert(expenses: inout [Expense]) {
        if let currencies = currencies.currency {
            for expense in expenses {
                expense.price *= currencies.data!["\(String(describing: expense.currency))"]!
            }
        }
    }
}
