//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    let coreDataManager = CoreDataManager()
    @State var expenses: [Expense]?
    
    var body: some View {
        NavigationView {
            List {
                
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
                await fetchCurrencies(baseCurrency: "sek")
            }
        }
    }
    
    func fetchCurrencies(baseCurrency: String) async {
        do {
            try await currencyViewModel.fetch(baseCurrency: "sek")
        } catch {
            errorHandler.handle(error: error)
        }
    }
}
