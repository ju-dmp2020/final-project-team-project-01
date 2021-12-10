//
//  AddCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel
    @ObservedObject var categoryModel = CategoryModel()
    
    // View States
    @FocusState private var nameFieldIsFocused: Bool
    @Binding var AddViewActive: Bool
    
    var body: some View {
        Form {
            Section(header: Text("Category name")) {
                TextField("Name must be between \(categoryModel.nameMinLength) and \(categoryModel.nameMaxLength)",
                          text: $categoryModel.name)
                    .focused($nameFieldIsFocused)
                    .onAppear {
                        // Auto focus
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            nameFieldIsFocused = true
                        }
                    }
            }
            Section {
                ColorPicker("Select a color", selection: $categoryModel.color, supportsOpacity: false)
            }
            Section {
                Button  {
                    // TODO: Save data
                    addCategory(name: categoryModel.name, color: categoryModel.color)
                    AddViewActive.toggle()
                } label: {
                    Text("Add")
                }
                .centerHorizontally()
            }.disabled(!categoryModel.isValid())
            
        }
        .navigationTitle("New category")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addCategory(name: String, color: Color) {
        if let CGColor = categoryModel.color.cgColor?.components {
            let floatColor = CGColor.map{Float($0)}
            categoryViewModel.add(name: name, color: floatColor)
        }
    }
}
