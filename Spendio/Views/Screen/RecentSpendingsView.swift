//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import SwiftUICharts

struct RecentSpendingsView: View {
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    // CoreData manager
    @Environment(\.managedObjectContext) var viewContext
    let coreDataManager = CoreDataManager()
    @State var expenses: [Expense]?
    
    var body: some View {
        NavigationView {
            VStack {
//                HStack{
//                    Spacer()
//                    BarChart()// 1. Graph
//                        .data(demoData)
//                        .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(.blue, .purple)))
//                    Spacer()
//                }
                
                Spacer()
                List{
                    if let expenses = expenses{
                        ForEach(expenses, id: \.self) {value in
                            Text("\(value.price)")
                        }
                    }
                    
                }
                // 2. List
            }
            .navigationTitle("Recent")
            .listStyle(.grouped)
            .alert(item: $currencyViewModel.currencyError) { err in
                Alert(title: Text("Whoops, an error occurred"),
                      message: Text(err.error.localizedDescription)
                )
            }
            .toolbar {
                FilterButtonView()
            }
        }
        .onAppear {
            Task { await currencyViewModel.fetch(baseCurrency: "sek") }
            // Return nil if error and goes to else statement above.
            expenses = try? coreDataManager.fetchRecentExpenses(limit: 10)
        }
    }
}



struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyViewModel: CurrencyViewModel())
    }
}
