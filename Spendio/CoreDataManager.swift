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
    // Maybe put context variable outside functions
    
    func addCategory(name: String) throws {
        let context = controller.container.viewContext
        
        let newCategory = Category(context: context)
        newCategory.id = UUID()
        newCategory.name = name
        
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    
     func fetchAllCategories() throws -> [Category]  {
        let context = controller.container.viewContext
        // Kolla på CategoriesViewModel
        // Skapa extensions för fetchRequest parameter??
         
         let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = []
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      
        do {
            try fetchedResultsController.performFetch()
            guard let categories = fetchedResultsController.fetchedObjects else {
                return []
            }
            return categories
            
        } catch {
            throw error
        }
        
        
    }
    
    
}
