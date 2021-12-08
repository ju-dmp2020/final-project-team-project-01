//
//  ExpenseViewModel.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-08.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    let coreDataManager = CoreDataManager()
    
    @Published var expenses: [Expense]?
    @Published var expense: Expense?
    
    func fetchAll() throws {
        do {
            let result = try coreDataManager.fetchAllExpenses()
            DispatchQueue.main.async {
                self.expenses = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            throw error
        }
    }
    
    func fetchRecentExpenses(limit: Int) throws{
        do{
            let result = try coreDataManager.fetchRecentExpenses(limit: limit)
            DispatchQueue.main.async {
                self.expenses = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            throw error
        }
    }
    
    func add(title: String, price: Double, date: Date, currency: String, category: Category ) throws {
        do {
            try coreDataManager.addExpense(title: title, price: price, date: date, currency: currency, category: category)
        } catch {
            throw error
        }
    }
    
    func update(expense: Expense, title: String, price: Double, date: Date, currency: String, category: Category) throws {
        do {
            try coreDataManager.updateExpense(expense: expense, title: title, price: price, date: date, currency: currency, category: category)
        } catch {
            throw error
        }
    }
    
    func delete(expense: Expense ) throws {
        do {
            try coreDataManager.deleteExpense(expense: expense)
            try self.fetchAll() // update changes here
        } catch {
            throw error
        }
    }
}
