//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
    @State private var editViewActive: Bool = false
    @State private var AddViewActive: Bool = false
    @State private var editViewCategoryId = 0 // Example value
    // ViewModel
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var categoryViewModel =  CategoryViewModel()
    var body: some View {
        NavigationView {
            VStack {
                // Always hidden & redirects to EditCategoryView on swipe action
                NavigationLink("", isActive: $editViewActive) {
                    EditCategoryView(id: $editViewCategoryId)
                }.hidden().frame(width: 0, height: 0)
                
                List {
                    if let categories = categoryViewModel.categories {
                        ForEach (categories) { category in
                            CategoryRowView(editViewActive: $editViewActive, category: category)
                        } // send obj later
                    }
                    
                }
                .listStyle(.grouped)
                .navigationTitle("Categories")
                .toolbar {
                    NavigationLink(destination: AddCategoryView(categoryViewModel: categoryViewModel, AddViewActive: $AddViewActive),
                                   isActive: $AddViewActive) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .onAppear {
                try! categoryViewModel.fetchAll() // handle errors later
            }
        }
    }
    
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categoryViewModel: CategoryViewModel())
    }
}
