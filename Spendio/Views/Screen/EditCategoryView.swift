//
//  EditCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-27.
//

import SwiftUI

struct EditCategoryView: View {
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
    // Necessary variables for category
    @Binding var id: UUID
    var category: CategoryModel?
    
    // Prefil textfield & colorpicker
    @State var categoryName: String = ""
    @State var categoryColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    init(categoryId: Binding<UUID>) {
        self._id = categoryId
        self.category = try? coreDataManager.fetchCategoryById(id: self.id)
    }
    
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
