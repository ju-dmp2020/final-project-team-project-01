//
//  CategoryViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-01.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    let coreDataManager = CoreDataManager()
    
    @Published var categories: [Category]?
    @Published var category: Category?
    
    func fetchAll() throws {
        do {
            let result = try coreDataManager.fetchAllCategories()
            DispatchQueue.main.async {
                self.categories = result
                self.objectWillChange.send() // Force change
            }
        } catch {
            throw error
        }
    }
    
    func add(name: String, color: [Float]) throws {
        do {
            try coreDataManager.addCategory(name: name, color: color)
        } catch {
            throw error
        }
    }
    
    func update(category: Category, name: String, color: [Float]) throws {
        do {
            try coreDataManager.updateCategory(category: category, name: name, color: color)
        } catch {
            throw error
        }
    }
    
    func delete(category: Category) throws {
        do {
            try coreDataManager.deleteCategory(category: category)
            try self.fetchAll() // update changes here
        } catch {
            throw error
        }
    }
}
