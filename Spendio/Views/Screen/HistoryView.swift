//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var currencyViewModel: CurrencyViewModel

    var body: some View {
        NavigationView {
            List {
                
                // Example
                if let currency = currencyViewModel.currency?.data {
                    Text("1 SEK == \(currency["GBP"]!) GBP")
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
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currencyViewModel: CurrencyViewModel())
    }
}
