//
//  AddExpenseView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct AddExpenseView: View {
    @Binding var tabScreen: TabScreen
    @State private var date = Date()
    @State private var cost = ""
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Title")){
                    TextField("Title", text: $title)
                }
                Section(header: Text("Cost")){
                    TextField("Cost",text: $cost)
                        .keyboardType(.decimalPad)
                }
                
                Section("Date"){
                    //DatePicker("Transaction Date", selection: $expense.transactionDate, displayedComponents: [.date])
                }
                
                Section{
                    Button {
                        print("Submitted!")
                        tabScreen = TabScreen.recentSpendings
                    } label: {
                        Text("Add Expense")
                    }.centerHorizontally()
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
