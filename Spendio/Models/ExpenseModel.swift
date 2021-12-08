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
    @Published var category: Category = Category()
    
    let titleMinLength: Int = 2
    let titleMaxLength: Int = 10
    let priceMinValue: Double = 0
    
    func validateTitleLength() -> Bool {
        title.count >= titleMinLength && title.count <= titleMaxLength
    }
    
    func validatePriceValue() -> Bool {
        Double(price) ?? -1 >= priceMinValue
    }
    
    // Generic name / function in case more validation added
    func isValid() -> Bool {
        self.validateTitleLength() && self.validatePriceValue()
    }
}
