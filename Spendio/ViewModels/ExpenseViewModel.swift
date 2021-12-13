//
//  ExpenseViewModel.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-08.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    private let errorHandler = ErrorHandler.shared
    private let settings = SettingsViewModel.shared
    private let coreDataManager = CoreDataManager()
    private let priceConverter = PriceConverterModel()
    
    @Published var expenses: [Expense]?
    @Published var expense: Expense?
    
    func fetchAll() {
        if let _ = settings.baseCurrency {
            fetchAllAsync()
        } else {
            fetchAllNonAsync()
        }
    }
    
    private func fetchAllAsync() {
        Task {
            do {
                try await priceConverter.fetchCurrencies()
                let expenses = try coreDataManager.fetchAllExpenses()
                DispatchQueue.main.async {
                    self.expenses = expenses
                    self.objectWillChange.send() // Force change
                }
            } catch {
                errorHandler.handle(error: error)
            }
        }
    }
    
    private func fetchAllNonAsync() {
        do {
            let result = try coreDataManager.fetchAllExpenses()
            DispatchQueue.main.async {
                self.expenses = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            self.errorHandler.handle(error: error)
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
    
    func delete(expense: Expense) {
        do {
            try coreDataManager.deleteExpense(expense: expense)
            self.fetchAll()
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func convertPrice(expense: Expense) -> Double {
        return priceConverter.convert(expense: expense)
    }
    
    func modifyCurrencyLabel(expense: Expense) -> String? {
        return priceConverter.modifyCurrencyLabel(expense: expense)
    }
}
