//
//  AddCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct AddCategoryView: View {
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var categoryViewModel: CategoryViewModel
    
    @State var categoryName: String = ""
    @FocusState private var nameFieldIsFocused: Bool
    @State var categoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2) // Default color
    @Binding var AddViewActive: Bool
    
    var disableForm: Bool {
        categoryName.count < 3
    }
    
    var body: some View {
        Form {
            // TextField
            Section(header: Text("Category name")) {
                TextField("Name", text: $categoryName)
                    .focused($nameFieldIsFocused)
                    .onAppear {
                        // Auto focus
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            nameFieldIsFocused = true
                        }
                    }
            }
            // ColorPicker
            Section {
                ColorPicker("Select a color", selection: $categoryColor, supportsOpacity: false)
            }
            // Submit Button
            Section {
                Button  {
                    // TODO: Save data
                    addCategory(name: categoryName, color: categoryColor)
                    AddViewActive.toggle()
                } label: {
                    Text("Add")
                }
                .centerHorizontally()
            }.disabled(disableForm)
            
        }
        .navigationTitle("New category")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addCategory(name: String, color: Color) {
        if let CGColor = categoryColor.cgColor?.components {
            let floatColor = CGColor.map{Float($0)}
            do {
                try categoryViewModel.add(name: name, color: floatColor)
            } catch {
                errorHandler.handle(error: error)
            }
        }
    }
}
