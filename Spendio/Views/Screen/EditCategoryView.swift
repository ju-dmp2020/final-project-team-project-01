//
//  EditCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-27.
//

import SwiftUI

// https://stackoverflow.com/questions/28525962/how-to-update-existing-objects-in-core-data
// Fixa det senare

struct EditCategoryView: View {
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
    @Binding var category: Category?
    
    // Prefil textfield & colorpicker
    @State var categoryName: String = ""
    @State var categoryColor: Color = .yellow
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Category name")) {
                    TextField("Name", text: $categoryName)
                        .onAppear {
                            categoryName = category?.name ?? ""
                        }
                }
                Section {
                    ColorPicker("Select a color", selection: $categoryColor, supportsOpacity: false)
                        .onAppear {
                            categoryColor = Color(.sRGB, red: Double(category?.colorRed ?? 0.98),
                                                  green: Double(category?.colorGreen ?? 0.9),
                                                  blue: Double(category?.colorBlue ?? 0.2))
                        }
                }
                Section {
                    Button {
                        // TODO: Update Query to database
                        if let category = category {
                            if let CGColor = categoryColor.cgColor?.components {
                                let floatColor = CGColor.map{Float($0)}
                                try! coreDataManager.updateCategory(category: category, name: categoryName, color: floatColor) // handle error later
                            }
                        }
                    } label: {
                        Text("Save")
                    }
                    .centerHorizontally()
                }.disabled(disableForm)
            }
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var disableForm: Bool {
        categoryName.count < 3
    }
}
