//
//  EditCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-27.
//

import SwiftUI

struct EditCategoryView: View {
    @Binding var id: Int // Example value
    @State var categoryName: String = "" // Will be changed to a fetch result from db
    @State var categoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2) // Will be changed to a fetch result from db
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Category name")) {
                    TextField("Name", text: $categoryName)
                }
                Section {
                    ColorPicker("Select a color", selection: $categoryColor)
                }
                Section {
                    Button {
                        // TODO: Update Query to database
                        print(categoryColor)
                    } label: {
                        Text("Save")
                    }
                    .alignmentGuide(HorizontalAlignment.center){_ in 20}
                }
            }
        }
        .navigationBarTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        EditCategoryView(id: .constant(1))
    }
}
