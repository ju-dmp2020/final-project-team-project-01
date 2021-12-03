//
//  CategoriesView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct CategoriesView: View {
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    @State var categories: [Category]?
    
    // View states
    @State private var editViewActive: Bool = false
    @State private var AddViewActive: Bool = false
    @State private var editViewCategory: Category?
    
    var body: some View {
        NavigationView {
            VStack {
                if let categories = categories {
                    
                    // Always hidden & redirects to EditCategoryView on swipe action
                    NavigationLink("", isActive: $editViewActive) {
                        EditCategoryView(category: $editViewCategory)
                    }.hidden().frame(width: 0, height: 0)
                    
                    List {
                        ForEach (categories) { category in
                            CategoryRowView(editViewActive: $editViewActive,
                                            editViewCategory: $editViewCategory,
                                            categories: $categories,
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
                NavigationLink(destination: AddCategoryView(AddViewActive: $AddViewActive), isActive: $AddViewActive){
                    Image(systemName: "plus.circle")
                    
                }
            }
            .onAppear {
                // Return nil if error and goes to else statement above.
                categories = try? coreDataManager.fetchAllCategories()
            }
        }
    }
}
