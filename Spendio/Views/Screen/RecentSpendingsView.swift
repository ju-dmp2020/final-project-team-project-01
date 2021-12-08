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
    @StateObject var categoryViewModel = CategoryViewModel()
    var body: some View {
        NavigationView {
            VStack {
                BarChartView(data: ChartData(values: graphModel.populateChartData(expenses: expenseViewModel.expenses ?? [], categories: categoryViewModel.categories ?? [])), title: "Recent", style: graphModel.standardLightStyle , form: ChartForm.extraLarge, dropShadow: true)
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
        }
    }
}



/*struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyViewModel: CurrencyViewModel())
    }
}*/
