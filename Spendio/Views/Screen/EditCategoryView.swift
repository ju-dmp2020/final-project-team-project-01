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
    
    @Binding var category: Category?
    @Binding var editViewActive: Bool
    
    // Prefill textfield & colorpicker
    @State var categoryName: String = ""
    @State var categoryColor: Color = .yellow
    
    var disableForm: Bool {
        categoryName.count < 3
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
                        updateCategory(category: category, name: categoryName, color: categoryColor)
                        editViewActive.toggle()
                    } label: {
                        Text("Update")
                    }
                    .centerHorizontally()
                }.disabled(disableForm)
            }
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func updateCategory(category: Category?, name: String, color: Color) {
        if let category = category {
            if let CGColor = categoryColor.cgColor?.components {
                let floatColor = CGColor.map{Float($0)}
                do {
                    try categoryViewModel.update(category: category, name: name, color: floatColor)
                } catch {
                    errorHandler.handle(error: error)
                }
                
            }
        }
    }
}
