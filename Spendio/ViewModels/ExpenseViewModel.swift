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
    
    func add(title: String, price: Double, date: Date, currency: String, category: Category ) throws {
        do {
            try coreDataManager.addExpense(title: title, price: price, date: date, currency: currency, category: category)
        } catch {
            throw error
        }
    }
    
    /*func update(category: Category, name: String, color: [Float]) throws {
        do {
            try coreDataManager.updateCategory(category: category, name: name, color: color)
        } catch {
            throw error
        }
    }*/
    
    /*func delete(category: Category) throws {
        do {
            try coreDataManager.deleteCategory(category: category)
            try self.fetchAll() // update changes here
        } catch {
            throw error
        }
    }*/
}
