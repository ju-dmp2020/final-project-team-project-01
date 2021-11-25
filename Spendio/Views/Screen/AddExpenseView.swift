//
//  AddExpenseView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var tabScreen: TabScreen
    @StateObject var expense = Expense()
    @ObservedObject var expensesArray: Expenses
    @State private var date = Date()
    @State private var cost = ""
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Title")){
                    TextField("Title", text: $expense.title)
                }
                Section(header: Text("Cost")){
                    TextField("Cost",text: $cost)
                        .keyboardType(.decimalPad)
                }
                
                Section("Date"){
                    DatePicker("Transaction Date", selection: $expense.transactionDate, displayedComponents: [.date])
                }
                
                Section{
                    Button("Add Expense"){
                        expense.cost = Int(cost) ?? 0
                        print("Added expense: title: \(expense.title) cost: \(expense.cost) date: \(expense.transactionDate)")
                        expensesArray.addExpense(expense: expense)
                    }
                    .onSubmit {
                        print("Submitted!")
                    }
                    .alignmentGuide(HorizontalAlignment.center){_ in 50}
                }
            }
            .navigationTitle("Add Expense")
        }
    }
}

/*struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(tabScreen: TabScreen.RecentSpendings, expense: Expense(), expensesArray: Expenses())
    }
}*/
