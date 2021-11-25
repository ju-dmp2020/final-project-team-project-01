//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct RecentSpendingsView: View {
    @ObservedObject var currencyVM: CurrencyViewModel
    // Test
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        NavigationView {
            VStack {
                // 1. Graph
                // 2. List
            }
            .navigationTitle("Recent")
            .listStyle(.grouped)
            .alert(item: $currencyVM.currencyError) { err in
                Alert(title: Text("Whoops, an error occurred"),
                      message: Text(err.error.localizedDescription)
                )
            }
            .toolbar {
                FilterButtonView()
            }
        }
        .onAppear {
            Task { await currencyVM.fetch(baseCurrency: "sek") }
        }
    }
}

struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyVM: CurrencyViewModel(), expensesArray: Expenses())
    }
}
