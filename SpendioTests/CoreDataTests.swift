//
//  CoreDataTests.swift
//  SpendioTests
//
//  Created by Hasan Khalaf on 2021-12-11.
//

import XCTest
import CoreData
@testable import Spendio

class CoreDataTests: XCTestCase {
    var context: NSManagedObjectContext!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        context = getContainerForTesting()
        coreDataManager = CoreDataManager(context: context)
    }

    override func tearDown() {
        context?.undo()
    }
    
    func getContainerForTesting() -> NSManagedObjectContext {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let persistentContainer = NSPersistentContainer(name: "Spendio")
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return persistentContainer.viewContext
    }
    
    func testCreateCategory() throws {
        try coreDataManager.addCategory(name: "Hassan", color: [0.5, 0.3, 0.2])
    }

}
