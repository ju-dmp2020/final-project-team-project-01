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
    @Binding var editViewCategory: Category?
    @Binding var categories: [Category]? // Update View
    
    // Category Object
    let category: Category
    var body: some View {
        HStack {
            Circle()
                .fill(Color(.sRGB, red: Double(category.colorRed), green: Double(category.colorGreen), blue: Double(category.colorBlue)))
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)
            Text(category.name ?? "")
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
                editViewCategory = category
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .tint(.blue)
        }
        .confirmationDialog(
            "Are you sure you want to delete \(category.name ?? "")?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    // TODO: call a function to delete
                    deleteCategory(category: category)
                }
                Button("Cancel", role: .cancel) {}
            }
    }
    
    func deleteCategory(category: Category) {
        do {
            try coreDataManager.deleteCategory(category: category)
            categories = try coreDataManager.fetchAllCategories() // Update View
        } catch {
            print("Failed to delete & reload categories, \(error)")
        }
    }
}
