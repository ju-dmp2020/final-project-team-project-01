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
    
    func addCategory(name: String) {
        let context = controller.container.viewContext
        
        let newCategory = Category(context: context)
        newCategory.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func getAllCategories(){
        let context = controller.container.viewContext
        // Kolla på CategoriesViewModel
        // Skapa extensions för fetchRequest parameter??
        
        let request = Category.fetchRequest()
        request.sortDescriptors = []
        
        let fetchedRe
        sultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      
        do {
            try fetchedResultsController.performFetch()
            guard let catogries = fetchedResultsController.fetchedObjects else {
                return
            }
            return catogries
            
        } catch {
            print(error)
        }
        
        
    }
    
    
}
