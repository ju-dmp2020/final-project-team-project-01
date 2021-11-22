//
//  RecentSpendingsView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

struct RecentSpendingsView: View {
    @ObservedObject var expensesArray: Expenses
    var body: some View {
        List{
            
        }
    }
}

struct RecentSpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSpendingsView(expensesArray: Expenses())
    }
}
