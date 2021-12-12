//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import SwiftUICharts

struct RecentSpendingsView: View {
    @StateObject var expenseViewModel = ExpenseViewModel()
    @StateObject var categoryViewModel = CategoryViewModel()
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    if let expenses = expenseViewModel.expenses{
                        ForEach(expenses) {value in
                           ExpenseRowView(expense: value, expenseViewModel: expenseViewModel)
                        }
                    }
                }
                // 2. List
            }
            .navigationTitle("Recent")
            .listStyle(.grouped)
            .toolbar {
                SettingsButtonView()
            }
        }
        .onAppear {
            expenseViewModel.fetchRecentExpenses(limit: 10)
        }
    }
}
