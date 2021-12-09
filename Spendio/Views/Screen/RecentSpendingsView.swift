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
    @State var graphModel = GraphModel()
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var expenseViewModel = ExpenseViewModel()
    @StateObject var categoryViewModel = CategoryViewModel()
    var body: some View {
        NavigationView {
            VStack {
                BarChartView(data: ChartData(values: graphModel.chartData), title: "Recent", style: graphModel.standardLightStyle , form: ChartForm.extraLarge, dropShadow: true)
                List{
                    if let expenses = expenseViewModel.expenses{
                        ForEach(expenses, id: \.self) {value in
                           ExpenseRowView(expence: value)
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
            //Task { await currencyViewModel.fetch(baseCurrency: "sek") }
            // Return nil if error and goes to else statement above.
            do{
                try categoryViewModel.fetchAll()
            } catch {
                errorHandler.handle(error: error)
            }
            
            do{
                try expenseViewModel.fetchRecentExpenses(limit: 10)
            } catch {
                errorHandler.handle(error: error)
            }
            
            graphModel.populateChartData(expenses: expenseViewModel.expenses ?? [])
        }
    }
}



/*struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyViewModel: CurrencyViewModel())
    }
}*/
