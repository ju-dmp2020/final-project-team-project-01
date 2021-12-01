//
//  CategoryModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-01.
//

import Foundation


struct CategoryModel: Identifiable {
    let _category: Category
    var id: UUID
    var name: String
    
    init(category: Category) {
        self._category = category
        self.id = category.id ?? UUID()
        self.name = category.name ?? ""
    }
}
