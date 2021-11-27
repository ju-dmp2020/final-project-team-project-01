//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
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
                }.hidden().frame(width: 0, height: 0)
                
                List {
                    ForEach (categories, id: \.self) { category in
                        CategoryRowView(editViewActive: $editViewActive,
                                        editViewCategoryId: $editViewCategoryId,
                                        categoryName: category,
                                        categoryColor: Color.brown)
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
