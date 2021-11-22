//
//  HistoryView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var expensesArray: Expenses
    @ObservedObject var currencyVM: CurrencyViewModel
    var body: some View {
        Text("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(expensesArray: Expenses(), currencyVM: CurrencyViewModel())
    }
}
