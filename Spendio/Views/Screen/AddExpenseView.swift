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
    
    let currencies = ["SEK", "EUR", "USD", "NOK"]
    
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
    @Binding var tabScreen: TabScreen
    @State private var date = Date()
    @State private var price = ""
    @State private var title = ""
    @State private var currency: String = "SEK"
    @State private var category = Category()
    @State private var categories: [Category] = []
    @State private var test: Bool = false
    
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Title")){
                    TextField("Title", text: $title)
                }
                Section(header: Text("Price")){
                    HStack{
                        TextField("Price",text: $price)
                            .keyboardType(.decimalPad)
                        Picker("Currency", selection: $currency) {
                            ForEach(currencies, id: \.self) { value in
                                Text(value)
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section("Date"){
                    DatePicker("Transaction Date", selection: $date, displayedComponents: [.date])
                }
                
                Section("Category"){
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { value in
                            Text(value.name ?? "null")
                                .tag(value)
                        }
                    }
                }
                
                
                Section{
                    Button {
                        print("+++ currency selected: \(currency)")
                        try? coreDataManager.addExpense(title: title, price: Double(price)!, date: date, currency: currency, category: category)
                        tabScreen = TabScreen.recentSpendings
                    } label: {
                        Text("Add Expense")
                    }.centerHorizontally()
                }
            }
            .navigationTitle("Add Expense")
            .onAppear{
                fetchAllCategories()
                test.toggle()
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
