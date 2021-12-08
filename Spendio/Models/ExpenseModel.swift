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
        // Convert to Double
        if let price = Double(price) {
            if price >= priceMinValue {
                return true
            }
            return false
        }
        return false
    }
    
    // Generic name / function in case more validation added
    // using not "!" because the function is used inside .disabled
    func isValid() -> Bool {
        !validateTitleLength() && !validatePriceValue()
    }
}
