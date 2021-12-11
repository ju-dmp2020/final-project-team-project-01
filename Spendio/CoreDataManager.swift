//
//  CoreDataManager.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-01.
//

import Foundation
import CoreData

struct CoreDataManager {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError where error.code == NSPersistentStoreSaveError {
                throw CoreDataError.savePermission
            } catch {
                throw CoreDataError.saveGeneral
            }
        }
    }
    
    func addCategory(name: String, color: [Float]) throws {
        
        let newCategory = Category(context: context)
        newCategory.name = name
        newCategory.colorRed = color[0]
        newCategory.colorGreen = color[1]
        newCategory.colorBlue = color[2]
        
        try save()
    }
    
     func fetchAllCategories() throws -> [Category]  {
         
         let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
         do {
             let categories = try context.fetch(fetchRequest)
             return categories
         } catch {
             throw CoreDataError.fetch
         }
    }
    
    func updateCategory (category: Category, name: String, color: [Float]) throws {
        category.name = name
        category.colorRed = color[0]
        category.colorGreen = color[1]
        category.colorBlue = color[2]
        
        try save()
    }
    
    func deleteCategory(category: Category) throws {
        context.delete(category)
        
        try save()
    }
    
    func addExpense(title: String, price: Double, date: Date, currency: String, category: Category?) throws {
        
        let newExpense = Expense(context: context)
        
        newExpense.title = title
        newExpense.price = price
        newExpense.date = date
        newExpense.currency = currency
        
        if let category = category {
            newExpense.category = category
        }
        
        try save()
    }
    
    func fetchAllExpenses() throws -> [Expense]  {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
       
        let expenses = try context.fetch(fetchRequest)
        return expenses
   }
    
    func fetchRecentExpenses(limit: Int) throws -> [Expense]  {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.fetchLimit = limit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let expenses = try context.fetch(fetchRequest)
            return expenses
        } catch {
            throw CoreDataError.fetch
        }
    }
    
    func updateExpense (expense: Expense, title: String, price: Double, date: Date, currency: String, category: Category) throws {
        expense.title = title
        expense.price = price
        expense.date = date
        expense.currency = currency
        expense.category = category
        
        try save()
    }
    
    func deleteExpense(expense: Expense) throws {
        context.delete(expense)
        
        try save()
    }
}
