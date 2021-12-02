//
//  CategoryRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct CategoryRowView: View {
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
    // View States
    @State private var showDeleteConfirmation: Bool = false
    @Binding var editViewActive: Bool
    @Binding var editViewCategoryId: UUID
    @Binding var categories: [CategoryModel]?
    
    // Category Object
    let category: CategoryModel
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(.sRGB, red: Double(category.colorRed), green: Double(category.colorGreen), blue: Double(category.colorBlue)))
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)
            Text(category.name)
        }
        .padding(.vertical, 10)
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
                editViewCategoryId = category.id
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .tint(.blue)
        }
        .confirmationDialog(
            "Are you sure you want to delete \(category.name)?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    // TODO: call a function to delete
                    deleteCategory(categoryId: category.id)
                }
                Button("Cancel", role: .cancel) {}
            }
    }
    
    func deleteCategory(categoryId: UUID) {
        do {
            try coreDataManager.deleteCategory(id: categoryId)
            categories = try coreDataManager.fetchAllCategories() // Update View
        } catch {
            print("Failed to delete & reload categories, \(error)")
        }
    }
}
