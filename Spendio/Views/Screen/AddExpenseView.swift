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
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct AddExpenseView: View {
    let categoryModel = CategoryViewModel()
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    
    @Binding var tabScreen: TabScreen
    @State private var date = Date()
    @State private var price = ""
    @State private var title = ""
    @State private var currency: String = "SEK"
    @State private var categories: [Category] = []
    
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Title")){
                    TextField("Title", text: $title)
                }
                Section(header: Text("Cost")){
                    TextField("Cost",text: $price)
                        .keyboardType(.decimalPad)
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { value in
                            Text(value.localizedName)
                                .tag(value)
                        }
                    }
                }
                
                Section("Date"){
                    DatePicker("Transaction Date", selection: $date, displayedComponents: [.date])
                }
                
                Section("Category"){
                    Picker("Category", selection: $categories) {
                        ForEach(categories, id: \.self) { value in
                            Text(value.name ?? "null")
                                .tag(value)
                        }
                    }
                }
                
                
                Section{
                    Button {
                        
                        try? coreDataManager.addExpense(title: title, price: Double(price)!, date: date, currency: currency)
                        tabScreen = TabScreen.recentSpendings
                    } label: {
                        Text("Add Expense")
                    }.centerHorizontally()
                }
            }
            .navigationTitle("Add Expense")
            .onAppear(perform: {
                categoryModel.fetchAll()
                if let fetchedCategories = categoryModel.categories{
                    categories = fetchedCategories
                }
            })
        }
    }
}

/*struct AddExpenseView_Previews: PreviewProvider {
 static var previews: some View {
 AddExpenseView(tabScreen: TabScreen.RecentSpendings, expense: Expense(), expensesArray: Expenses())
 }
 }*/
