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
        context.undo()
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
        let categoryName = "category"
        try coreDataManager.addCategory(name: categoryName, color: [0.5, 0.3, 0.2])
        let fetchedCategory = try? coreDataManager.fetchCategoryByName(name: categoryName)
        
        XCTAssertEqual(categoryName, try? XCTUnwrap(fetchedCategory?.name))
    }
    
    func testDeleteCategory() throws {
        let categoryName = "category"
        // Insert
        try coreDataManager.addCategory(name: categoryName, color: [0.5, 0.3, 0.23])
        // Fetch
        var fetchedCategory = try coreDataManager.fetchCategoryByName(name: categoryName)
        // Delete
        try coreDataManager.deleteCategory(category: try XCTUnwrap(fetchedCategory))
        
        // nil if deleted
        fetchedCategory = try coreDataManager.fetchCategoryByName(name: categoryName)
        XCTAssertNil(fetchedCategory)
    }
}
