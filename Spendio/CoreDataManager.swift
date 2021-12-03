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
    
    func fetchCategoryById(id: UUID) throws -> Category? {
        let context = controller.container.viewContext
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let category = try context.fetch(fetchRequest).first
        return category
    }
    
    
     func fetchAllCategories() throws -> [Category]  {
         let context = controller.container.viewContext
         
         let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
         let categories = try context.fetch(fetchRequest)
         return categories
    }
    
    func updateCategory (category: Category, name: String, color: [Float]) throws {
        let context = controller.container.viewContext
        
        category.name = name
        category.colorRed = color[0]
        category.colorGreen = color[1]
        category.colorBlue = color[2]
        
        try context.save()
    }
    
    func deleteCategory(category: Category) throws {
        let context = controller.container.viewContext
        // Delete
        context.delete(category)
        
        try context.save()
    }
    
    func addExpense(title: String, price: Double, date: Date, currency: String) throws {
        let context = controller.container.viewContext
        
        let newExpense = Expense(context: context)
        newExpense.id = UUID()
        newExpense.title = title
        newExpense.price = price
        newExpense.date = date
        newExpense.currency = currency
        //newExpense.category = Category()
        
        try context.save()
    }
    
    func fetchRecentExpenses(limit: Int) throws -> [Expense]  {
        let context = controller.container.viewContext
        
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
       
        let expenses = try context.fetch(fetchRequest)
        return expenses
   }
}
