//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import SwiftUICharts

struct RecentSpendingsView: View {
    @State var demoData: [Double] = [5,13,11,3,14,16]
    @ObservedObject var currencyVM: CurrencyViewModel
    // Test
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    BarChart()// 1. Graph
                        .data(demoData)
                        .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(.blue, .purple)))
                    Spacer()
                }
                
                Spacer()
                List{
                    ForEach(demoData, id: \.self) {value in
                        Text("\(value)")
                    }
                }
                // 2. List
            }
            .navigationTitle("Recent")
            .listStyle(.grouped)
            .alert(item: $currencyVM.currencyError) { err in
                Alert(title: Text("Whoops, an error occurred"),
                      message: Text(err.error.localizedDescription)
                )
            }
            .toolbar {
                FilterButtonView()
            }
        }
        .onAppear {
            Task { await currencyVM.fetch(baseCurrency: "sek") }
        }
    }
}



struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyVM: CurrencyViewModel(), expensesArray: Expenses())
    }
}
