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
    @StateObject var expenseViewModel = ExpenseViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                if let expenses = expenseViewModel.expenses{
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
            do {
               try expenseViewModel.fetchAll()
            } catch {
                errorHandler.handle(error: error)
            }
            
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
