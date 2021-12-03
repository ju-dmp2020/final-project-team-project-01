//
//  CategoryViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-01.
//

import Foundation

// 1. FetchRequest in views
// 2. Use viewmodel class with objectwillchange.send() to "brute force" changes.

/*
class CategoryViewModel: ObservableObject {
    
    @Published var categories: [CategoryModel]?
    @Published var category: CategoryModel?
    
    let coreDataManager = CoreDataManager()
    
    func fetchAll() throws {
        var result: [CategoryModel]
        do {
            result = try coreDataManager.fetchAllCategories().map(CategoryModel.init)
        } catch {
            throw error
        }
        
        DispatchQueue.main.async {
            self.categories = result
            self.objectWillChange.send()
        }
    }
    
    func fetchById(id: UUID) throws {
        
        let fetchedCategory = try coreDataManager.fetchCategoryById(id: id).map(CategoryModel.init)
        DispatchQueue.main.async {
            self.category = fetchedCategory
        }
        
    }
    
    func add(name: String, color: [Float]) throws {
        
        do {
            try coreDataManager.addCategory(name: name, color: color)
        } catch {
            throw error
        }
    }
    
}
*/
