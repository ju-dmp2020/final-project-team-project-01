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

    @EnvironmentObject var errorHandler: ErrorHandler


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
            .toolbar {
                FilterButtonView()
            }
        }
        .onAppear {
            Task {
                do {
                    try await currencyViewModel.fetch(baseCurrency: "sek")
                } catch {
                    errorHandler.handle(error: error)
                }
            }
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
