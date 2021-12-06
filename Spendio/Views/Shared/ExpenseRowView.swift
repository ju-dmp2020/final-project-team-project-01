//
//  ExpenseRowView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-20.
//

import SwiftUI

struct ExpenseRowView: View {
    let expence: Expense
    var body: some View {
        HStack{
            Circle() 
                .fill(.green)
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)
            Text("\(expence.title ?? "None" )")
            Spacer()
            Text("\(expence.price, specifier: "%.2f")")
                .foregroundColor(.red)
        }
    }
}

/*struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView()
    }
}*/
