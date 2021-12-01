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

    var body: some View {
        NavigationView {
            List {
                
                // Example
                if let currency = currencyVM.currency?.data {
                    Text("1 SEK == \(currency["GBP"]!) GBP")
                }
                
            }
            .navigationTitle("History")
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

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currencyVM: CurrencyViewModel())
    }
}
