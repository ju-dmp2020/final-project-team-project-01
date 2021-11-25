//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var currencyVM: CurrencyViewModel
    @State var catchedError: String? = nil
    // Test
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        NavigationView {
            List {
                // Remove it if u want
                if let currency = currencyVM.currency?["sek"] {
                    Text("\(currency)" as String)
                }
            }
            .navigationTitle("History")
            .listStyle(.grouped)
            .alert(item: $currencyVM.currencyError) { err in
                Alert(title: Text("Whoops, an error occurred"),
                      message: Text(err.error.localizedDescription)
                )
            }
        }
        .onAppear {
            Task { await currencyVM.fetch(baseCurrency: "sek") }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currencyVM: CurrencyViewModel(), expensesArray: Expenses())
    }
}

// Example usage of currency rates
/*
if let currency = currencyVM.currency?["sek"] {
    Text("\(currency)" as String)
} */
