//
//  CategoryModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-01.
//

import Foundation
import CoreData.NSManagedObjectID


struct CategoryModel: Identifiable {
    let objectID: NSManagedObjectID
    let id: UUID
    let name: String
    let colorRed: Float
    let colorGreen: Float
    let colorBlue: Float
    
    init(category: Category) {
        self.objectID = category.objectID
        self.id = category.id ?? UUID()
        self.name = category.name ?? ""
        self.colorRed = category.colorRed
        self.colorGreen = category.colorGreen
        self.colorBlue = category.colorBlue
    }
}
