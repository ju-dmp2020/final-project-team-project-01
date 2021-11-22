//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
    // Example data
    @State private var categories = ["Games", "Food", "Coffee"]
    @State private var showDeleteConfirmation: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach (categories, id: \.self) { category in
                    NavigationLink(destination: CategoryView(category: category)) {
                        CategoryRowView(category: category)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            showDeleteConfirmation = true
                            } label: {
                                Image(systemName: "trash")
                            }

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
            .padding(.top)
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

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
