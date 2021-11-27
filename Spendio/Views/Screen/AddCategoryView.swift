//
//  AddCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct AddCategoryView: View {
    @State var categoryName: String = ""
    @FocusState private var nameFieldIsFocused: Bool
    @State var categoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2) // Default color
    
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
                    print(categoryColor)
                } label: {
                    Text("Save")
                }
                .alignmentGuide(HorizontalAlignment.center){_ in 20}
            }
            
        }
        .navigationTitle("New category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(categoryName: "")
    }
}
