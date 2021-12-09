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
    let graphModel = GraphModel()
    @State var chartDemoData = ChartData(values: [("Food",90), ("Coffe",50),("Cars",450),("Candy",120),("Entertainment",200),("Home",300),("Fika",65)])
    @State var demoData: [Double] = [5.0,13.0,11.0,3.0,14.0,16.0]
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var expenseViewModel = ExpenseViewModel()
    var body: some View {
        NavigationView {
            VStack {
                BarChartView(data: chartDemoData, title: "Recent", style: graphModel.standardLightStyle , form: ChartForm.extraLarge, dropShadow: true)
                List{
                    if let expenses = expenseViewModel.expenses{
                        ForEach(expenses, id: \.self) {value in
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
