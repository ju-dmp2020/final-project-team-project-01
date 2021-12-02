//
//  CoreDataManager.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-01.
//

import Foundation
import CoreData

struct CoreDataManager {
    let controller = PersistenceController.shared
    
    func addCategory(name: String, color: [Float]) throws {
        let context = controller.container.viewContext
        
        let newCategory = Category(context: context)
        newCategory.id = UUID()
        newCategory.name = name
        newCategory.colorRed = color[0]
        newCategory.colorGreen = color[1]
        newCategory.colorBlue = color[2]
        
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func fetchCategoryById(id: UUID) throws -> CategoryModel? {
        let context = controller.container.viewContext
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let category = try context.fetch(fetchRequest).first
        return category.map(CategoryModel.init)
    }
    
    
     func fetchAllCategories() throws -> [CategoryModel]  {
         let context = controller.container.viewContext
         
         let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
         let categories = try context.fetch(fetchRequest)
         return categories.map(CategoryModel.init)
    }
    
    func deleteCategory(id: UUID) throws {
        let context = controller.container.viewContext
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let category = try context.fetch(fetchRequest).first
        
        // Delete
        if let category = category {
            context.delete(category)
            try context.save()
        }
    }
}
