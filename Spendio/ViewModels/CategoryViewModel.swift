//
//  CategoryViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-01.
//

import Foundation

class CategoryViewModel: ObservableObject {
    let coreDataManager = CoreDataManager()
    let errorHandler = ErrorHandler.shared
    
    @Published var categories: [Category]?
    @Published var category: Category?
    
    func fetchAll() {
        do {
            let result = try coreDataManager.fetchAllCategories()
            DispatchQueue.main.async {
                self.categories = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func add(name: String, color: [Float]) {
        do {
            try coreDataManager.addCategory(name: name, color: color)
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func update(category: Category, name: String, color: [Float]) {
        do {
            try coreDataManager.updateCategory(category: category, name: name, color: color)
        } catch {
            errorHandler.handle(error: error)
        }
    }
    
    func delete(category: Category) throws {
        do {
            try coreDataManager.deleteCategory(category: category)
            self.fetchAll() // update changes here
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
