//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct RecentSpendingsView: View {
    @ObservedObject var currencyVM: CurrencyViewModel
    @State var thrownError: String? = nil
    // Test
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        VStack {
            if thrownError != nil {
                APIErrorView(thrownError: $thrownError)
            } else {
                Text("Recent")
            }
        }
        .onAppear {
            Task {
                do { try await currencyVM.fetch(baseCurrency: "hejhej") } catch {
                    thrownError = error.localizedDescription
                }
            }
        }
    }
}

struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(currencyVM: CurrencyViewModel(), expensesArray: Expenses())
    }
}
