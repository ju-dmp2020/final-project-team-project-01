//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var currencyViewModel: CurrencyViewModel
    let coreDataManager = CoreDataManager()
    @State var expenses: [Expense]?

    var body: some View {
        NavigationView {
            List {
                
                // Example
                /*if let currency = currencyViewModel.currency?.data {
                    Text("1 SEK == \(currency["GBP"]!) GBP")
                }*/
                
                if let expenses = expenses{
                    ForEach(expenses, id: \.self) {value in
                        ExpenseRowView(expence: value)                    }
                }
                
            }
            .navigationTitle("History")
            .listStyle(.grouped)
            .alert(item: $currencyViewModel.currencyError) { err in
                Alert(title: Text("Whoops, an error occurred"),
                      message: Text(err.error.localizedDescription)
                )
            }
            .toolbar {
                FilterButtonView()
            }
        }
        .onAppear {
            Task { await currencyViewModel.fetch(baseCurrency: "sek") }
        }
        .onAppear{
            expenses = try? coreDataManager.fetchAllExpenses()
        }
    }
}

/*struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currencyViewModel: CurrencyViewModel())
    }
}*/
