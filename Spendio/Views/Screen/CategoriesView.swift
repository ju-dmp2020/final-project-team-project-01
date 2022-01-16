//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var categoryViewModel = CategoryViewModel()
    
    // View states
    @State private var editViewActive: Bool = false
    @State private var AddViewActive: Bool = false
    @State private var editViewCategory: Category?
    
    var body: some View {
        NavigationView {
            VStack {
                if let categories = categoryViewModel.categories {
                    
                    // Always hidden & redirects to EditCategoryView on swipe action
                    NavigationLink("", isActive: $editViewActive) {
                        EditCategoryView(categoryViewModel: categoryViewModel, category: $editViewCategory, editViewActive: $editViewActive)
                    }.hidden().frame(width: 0, height: 0)
                    
                    List {
                        ForEach (categories) { category in
                            CategoryRowView(categoryViewModel: categoryViewModel,
                                            editViewActive: $editViewActive,
                                            editViewCategory: $editViewCategory,
                                            category: category)
                        }
                    }
                } else {
                    Text("Couldn't fetch data")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Categories")
            .toolbar {
                NavigationLink(destination: AddCategoryView(categoryViewModel: categoryViewModel, AddViewActive: $AddViewActive), isActive: $AddViewActive){
                    Image(systemName: "plus.circle")
                    
                }
            }
            .onAppear {
                categoryViewModel.fetchAll()
            }
        }
    }
}
