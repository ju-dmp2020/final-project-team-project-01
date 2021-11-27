//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
    @State private var showDeleteConfirmation: Bool = false
    @State private var editViewActive: Bool = false
    @State private var editViewCategoryId = 0 // Example value
    // Example data
    @State private var categories = ["Games", "Food", "Coffee"]
    var body: some View {
        NavigationView {
            VStack {
                // Always hidden & redirects to EditCategoryView on swipe action
                NavigationLink("", isActive: $editViewActive) {
                    EmptyView() // Will be replaced with EditCategoryView()
                }
                .hidden()
                .frame(width: 0, height: 0)
                
                // Categories
                List {
                    ForEach (categories, id: \.self) { category in
                        CategoryRowView(categoryName: category, categoryColor: Color.blue) // Example parameters
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    showDeleteConfirmation = true
                                } label: {
                                    Image(systemName: "trash")
                                }
                                
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    editViewActive.toggle()
                                    editViewCategoryId = 5 // Example value
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                }
                                .tint(.blue)
                            }
                            .confirmationDialog(
                                "Are you sure you want to delete \(category)?",
                                isPresented: $showDeleteConfirmation,
                                titleVisibility: .visible) {
                                    Button("Yes", role: .destructive) {
                                        // TODO: call a ViewModel function to delete
                                    }
                                    Button("Cancel", role: .cancel) {}
                                }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("Categories")
                .toolbar {
                    NavigationLink(destination: AddCategoryView()) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
