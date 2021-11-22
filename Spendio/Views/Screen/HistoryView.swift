//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var currencyVM: CurrencyViewModel
    @State var catchedError: String? = nil
    // Test
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        VStack {
            Text("Recent")
            if let catchedError = catchedError {
                Text("Error: \(catchedError)")
            }
            

        }
        .onAppear {
            Task {
                do {
                    try await currencyVM.fetch(baseCurrency: "sek")
                } catch {
                    catchedError = error.localizedDescription
                }
                
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(currencyVM: CurrencyViewModel(), expensesArray: Expenses())
    }
}
