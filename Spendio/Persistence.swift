//
//  Persistence.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Spendio")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Should not crash unless its a big problem
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
