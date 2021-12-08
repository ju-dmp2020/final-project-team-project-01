//
//  AddExpenseView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

enum Currency: String , Equatable, CaseIterable {
    case sek = "SEK"
    case eur = "EUR"
    case usd = "USD"
    case nok = "NOK"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct AddExpenseView: View {
    @EnvironmentObject var errorHandler: ErrorHandler
    @StateObject var categoryViewModel = CategoryViewModel()
    @StateObject var expenseViewModel = ExpenseViewModel()
    
    let currencies = ["SEK", "EUR", "USD", "NOK"]
    
    @Environment(\.managedObjectContext) var viewContext
    
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
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency)
                                    .tag(currency)
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
                        ForEach(categoryViewModel.categories ?? [], id: \.self) { value in
                            HStack{
                                Text(value.name ?? "null")
                                    .tag(value)
                            }
                        }
                    }
                }
                
                
                Section{
                    Button {
                        try? expenseViewModel.add(title: expenseModel.title,
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
                fetchAllCategories()
            }
        }
    }
    
    func fetchAllCategories() {
        do {
            try categoryViewModel.fetchAll()
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
