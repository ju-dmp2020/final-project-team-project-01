//
//  EditCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-27.
//

import SwiftUI

struct EditCategoryView: View {
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var categoryViewModel: CategoryViewModel
    @ObservedObject var categoryModel = CategoryModel()
    
    @Binding var category: Category?
    @Binding var editViewActive: Bool
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Category name")) {
                    TextField("Name must be between \(categoryModel.nameMinLength) and \(categoryModel.nameMaxLength)",
                              text: $categoryModel.name)
                        .onAppear {categoryModel.name = category?.name ?? ""}
                }
                Section {
                    ColorPicker("Select a color", selection: $categoryModel.color, supportsOpacity: false)
                        .onAppear {
                            categoryModel.color = Color(.sRGB, red: Double(category!.colorRed),
                                                        green: Double(category!.colorGreen),
                                                        blue: Double(category!.colorBlue))
                        }
                }
                Section {
                    Button {
                        // TODO: Update Query to database
                        updateCategory(category: category, name: categoryModel.name, color: categoryModel.color)
                        editViewActive.toggle()
                    } label: {
                        Text("Update")
                    }
                    .centerHorizontally()
                }.disabled(!categoryModel.isValid())
            }
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func updateCategory(category: Category?, name: String, color: Color) {
        if let category = category {
            if let CGColor = categoryModel.color.cgColor?.components {
                let floatColor = CGColor.map{Float($0)}
                categoryViewModel.update(category: category, name: name, color: floatColor)
            }
        }
    }
}
