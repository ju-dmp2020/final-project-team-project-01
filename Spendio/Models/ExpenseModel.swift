//
//  ExpenseModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-08.
//

import Foundation

class ExpenseModel: ObservableObject {
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var date: Date = .now                // Default as today
    @Published var currency: String = "SEK"         // Default currency
    @Published var category: Category?
    
    let titleMinLength: Int = 2
    let titleMaxLength: Int = 10
    let priceMinValue: Double = 0
    
    func resetValues() {
        title = ""
        price = ""
        date = .now
        currency = "SEK"
        category = nil
    }
    
    func validateTitleLength() -> Bool {
        title.count >= titleMinLength && title.count <= titleMaxLength
    }
    
    func validatePriceValue() -> Bool {
        Double(price) ?? -1 >= priceMinValue
    }
    
    func validateCurrencyLength() -> Bool{
        currency.count == 3     // Currencies shortcut
    }
    
    // Generic name / function in case more validation added
    func isValid() -> Bool {
        self.validateTitleLength() && self.validatePriceValue() && self.validateCurrencyLength()
    }
}
