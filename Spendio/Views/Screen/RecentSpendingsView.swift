//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import SwiftUICharts

struct RecentSpendingsView: View {
    @EnvironmentObject var errorHandler: ErrorHandler
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var expenseViewModel = ExpenseViewModel()
    @StateObject var categoryViewModel = CategoryViewModel()
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
                FilterButtonView()
            }
        }
        .onAppear {
            expenseViewModel.fetchRecentExpenses(limit: 10)
        }
    }
}
