//
//  FormValidationsTests.swift
//  SpendioTests
//
//  Created by Hasan Khalaf on 2021-12-09.
//

import XCTest
@testable import Spendio

class FormValidationsTests: XCTestCase {
    
    func testCategoryValidation() {
        let category = CategoryModel()
        let testString: String = "a string for testing"
        
        for char in testString {
            category.name += String(char)
            if category.name.count < category.nameMinLength || category.name.count > category.nameMaxLength {
                XCTAssertFalse(category.isValid())
            } else {
                XCTAssertTrue(category.isValid())
            }
        }
    }
    
    func testExpenseValidation() {
        let expense = ExpenseModel()
        
        // Test 1: Valid
        expense.title = "Valid"
        expense.price = "\(expense.priceMinValue)"
        expense.currency = "EUR"
        
        XCTAssertTrue(expense.isValid())
        
        // Test 2: Not Valid
        expense.title = "A long string that should not be valid"
        expense.price = "\(expense.priceMinValue + 30)"
        expense.currency = "SEK"
        
        XCTAssertFalse(expense.isValid())
        
        // Test 3: Not Valid
        expense.title = "Valid"
        expense.price = "letters"
        expense.currency = "SEK"
        
        XCTAssertFalse(expense.isValid())
        
        // Test 4: Not Valid
        expense.title = "Valid"
        expense.price = "\(expense.priceMinValue + 20)"
        expense.currency = "ABCD"
        
        XCTAssertFalse(expense.isValid())
        
        // Test 5: Not Valid
        expense.title = "Valid"
        expense.price = "\(expense.priceMinValue - 1)"
        expense.currency = "SEK"
        
        XCTAssertFalse(expense.isValid())
        
        // Test 5: Not Valid
        expense.title = "Valid"
        expense.price = "\(expense.priceMinValue)"
        expense.currency = "SE"
        
        XCTAssertFalse(expense.isValid())
    }
}
