//
//  AddExpenseView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI


struct AddExpenseView: View {
    @StateObject var categoryViewModel = CategoryViewModel()
    @StateObject var expenseViewModel = ExpenseViewModel()
    
    @ObservedObject var expenseModel = ExpenseModel()
    @Binding var tabScreen: TabScreen
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")){
                    TextField("Title must be between \(expenseModel.titleMinLength) and \(expenseModel.titleMaxLength)",
                              text: $expenseModel.title)
                }
                Section(header: Text("Price")){
                    HStack{
                        TextField("Price", text: $expenseModel.price)
                            .keyboardType(.decimalPad)
                        
                        Picker("Currency", selection: $expenseModel.currency) {
                            ForEach(Currency.allCases, id: \.self) { currency in
                                Text(currency.rawValue)
                                    .tag(currency.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section("Date"){
                    DatePicker("Transaction Date", selection: $expenseModel.date, displayedComponents: [.date])
                }
                
                Section("Category"){
                    Picker("Category", selection: $expenseModel.category) {
                        Text("Uncategorized").tag(nil as Category?)
                        ForEach(categoryViewModel.categories ?? [], id: \.self) { category in
                                Text(category.name ?? "").tag(category as Category?)
                        }
                    }
                }
                
                Section{
                    Button {
                        expenseViewModel.add(title: expenseModel.title,
                                             price: Double(expenseModel.price)!,
                                             date: expenseModel.date,
                                             currency: expenseModel.currency,
                                             category: expenseModel.category)
                        tabScreen = TabScreen.recentSpendings
                    } label: {
                        Text("Add Expense")
                    }.centerHorizontally()
                }.disabled(!expenseModel.isValid())
            }
            .navigationTitle("Add Expense")
            .onAppear{
                categoryViewModel.fetchAll()
            }
        }
    }
}
