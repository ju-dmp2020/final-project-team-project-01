//
//  ExpenseViewModel.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-08.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    let coreDataManager = CoreDataManager()
    let errorHandler = ErrorHandler.shared
    
    @Published var expenses: [Expense]?
    @Published var expense: Expense?
    
    func fetchAll() {
        do {
            let result = try coreDataManager.fetchAllExpenses()
            DispatchQueue.main.async {
                self.expenses = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func fetchRecentExpenses(limit: Int) {
        do{
            let result = try coreDataManager.fetchRecentExpenses(limit: limit)
            DispatchQueue.main.async {
                self.expenses = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func add(title: String, price: Double, date: Date, currency: String, category: Category?) {
        do {
            try coreDataManager.addExpense(title: title, price: price, date: date, currency: currency, category: category)
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func update(expense: Expense, title: String, price: Double, date: Date, currency: String, category: Category) {
        do {
            try coreDataManager.updateExpense(expense: expense, title: title, price: price, date: date, currency: currency, category: category)
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func delete(expense: Expense) {
        do {
            try coreDataManager.deleteExpense(expense: expense)
            self.fetchAll() // update changes here
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
