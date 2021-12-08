//
//  CategoryModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-07.
//

import Foundation
import SwiftUI

class CategoryModel: ObservableObject {
    @Published var name: String = ""
    @Published var color: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2) // Default color
    
    let nameMinLength: Int = 2
    let nameMaxLength: Int = 10
    
    func validateNameLength() -> Bool {
        name.count >= nameMinLength &&  name.count <= nameMaxLength
    }
    
    // Generic name / function in case more validation added
    func isValid() -> Bool {
        self.validateNameLength()
    }
}
