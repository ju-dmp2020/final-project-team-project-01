//
//  AddCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct AddCategoryView: View {
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
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
                    if let CGColor = categoryColor.cgColor?.components {
                        let floatColor = CGColor.map{Float($0)}
                        try! coreDataManager.addCategory(name: categoryName, color: floatColor) // handle error later
                    }
                    
                    AddViewActive.toggle()
                } label: {
                    Text("Save")
                }
                .centerHorizontally()
            }.disabled(disableForm)
            
        }
        .navigationTitle("New category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(categoryName: "", categoryViewModel: CategoryViewModel(), AddViewActive: .constant(false))
    }
}
*/
