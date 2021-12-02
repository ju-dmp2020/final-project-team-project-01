//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import SwiftUICharts

struct RecentSpendingsView: View {
    let graphModel = GraphModel()
    @State var chartDemoData = ChartData(values: [("Food",90), ("Coffe",50),("Cars",450),("Candy",120),("Entertainment",200),("Home",300),("Fika",65)])
    @State var demoData: [Double] = [5.0,13.0,11.0,3.0,14.0,16.0]
    @ObservedObject var currencyViewModel: CurrencyViewModel

    var body: some View {
        NavigationView {
            VStack {
                BarChartView(data: chartDemoData, title: "Recent", style: graphModel.standardLightStyle , form: ChartForm.extraLarge, dropShadow: true)
                List{
                    ForEach(demoData, id: \.self) {value in
                        Text("\(value)")
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
        }
    }
}



/*struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyViewModel: CurrencyViewModel())
    }
}*/
