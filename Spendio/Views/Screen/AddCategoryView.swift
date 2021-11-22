//
//  AddCategoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct AddCategoryView: View {
    @State var categoryName: String = ""
    @State private var showImageUploadSheet: Bool = false
    @FocusState private var isNameFieldFocused: Bool
    
    @State var showActionSheet: Bool = false
    
    
    var body: some View {
        Form {
            // TextField
            Section(header: Text("Category name")) {
                TextField("Name", text: $categoryName)
                    .focused($isNameFieldFocused)
                    .onAppear {
                        // Auto focus
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            isNameFieldFocused = true
                        }
                    }
                    .onSubmit {
                        categoryName = ""
                    }
            }
            // Image Upload
            Section {
                Button {
                    showImageUploadSheet = true
                } label: {
                    Text("Upload Image")
                }
                .confirmationDialog("", isPresented: $showImageUploadSheet, titleVisibility: .hidden) {
                        Button("Take Photo") {
                            // TODO: Camera functionality
                        }
                        Button("Gallery") {
                            // TODO: Choose en existing photo from gallery
                        }
                        Button("Cancel", role: .cancel) {}
                    }
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
