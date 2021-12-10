//
//  ExpenseRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct ExpenseRowView: View {
    let expense: Expense
    @ObservedObject var expenseViewModel: ExpenseViewModel
    @State private var showDeleteConfirmation: Bool = false 
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                //Spacer()
                Text("\(expense.title ?? "None" )")
                ZStack{
                    if let category = expense.category{
                        Capsule()
                            .fill(Color(red: Double(category.colorRed), green: Double(category.colorGreen), blue: Double(category.colorBlue), opacity: 1.0))
                            .frame(width: 70, height: 20)
                        Text("\(category.name ?? "None")")
                    }
                }
            }
            Spacer()
                Text("\(expense.price, specifier: "%.2f")")
                    .foregroundColor(.red)
                Text("\(expense.currency ?? "None")")
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                showDeleteConfirmation = true
            } label: {
                Image(systemName: "trash")
            }
        }
        .confirmationDialog(
            "Are you sure you want to delete \(expense.title ?? "")?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    // TODO: call a function to delete
                    expenseViewModel.delete(expense: expense)
                }
                Button("Cancel", role: .cancel) {}
            }
    }
}

/*struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView()
    }
}*/
