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
    @State private var deleteConfirmationShow: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach (categories, id: \.self) { category in
                    NavigationLink(destination: CategoryView(category: category)) {
                        CategoryRowView(category: category)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                                deleteConfirmationShow = true
                            } label: {
                                Image(systemName: "trash")
                            }

                    }
                    .confirmationDialog(
                        "Are you sure you want to delete \(category)?",
                        isPresented: $deleteConfirmationShow,
                        titleVisibility: .visible) {
                            Button("Yes", role: .destructive) {
                                
                            }
                            Button("No", role: .cancel) {
                                
                            }
                        }
                }
            }
            .padding(.top)
            .listStyle(.grouped)
            .navigationTitle("Categories")
            .toolbar {
                // EmptyView will be replaced with AddCategoryView()
                NavigationLink(destination: EmptyView()) {
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
