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
                    ForEach(expenses) {value in
                       ExpenseRowView(expense: value, expenseViewModel: expenseViewModel) // on conflict, override.
                    }
                }
            }
            .navigationTitle("History")
            .listStyle(.grouped)
            .toolbar {
                SettingsButtonView()
            }
        }
        .onAppear {
            do {
               try expenseViewModel.fetchAll()
            } catch {
                errorHandler.handle(error: error)
            }
            
            Task {
                await currencyViewModel.fetchCurrencies(baseCurrency: "sek")
            }
            expenseViewModel.fetchAll()
        }
    }
}
