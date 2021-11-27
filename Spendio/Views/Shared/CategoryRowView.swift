//
//  CategoryRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct CategoryRowView: View {
    // View States
    @State private var showDeleteConfirmation: Bool = false
    @Binding var editViewActive: Bool
    
    // Example Data
    @Binding var editViewCategoryId: Int
    let categoryName: String
    let categoryColor: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(categoryColor)
                .frame(width: 15, height: 15)
            Text(categoryName)
        }
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
            "Are you sure you want to delete \(categoryName)?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    // TODO: call a ViewModel function to delete
                }
                Button("Cancel", role: .cancel) {}
            }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(editViewActive: .constant(false),
                        editViewCategoryId: .constant(1),
                        categoryName: "Coffee",
                        categoryColor: Color.brown
        )
    }
}
