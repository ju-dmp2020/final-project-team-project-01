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
            /*Circle()
                .fill(.green)
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)*/
            VStack(alignment: .leading){
                Spacer()
                Text("\(expence.title ?? "None" )")
                ZStack{
                    if let category = expence.category{
                        Capsule()
                            .fill(Color(red: Double(category.colorRed), green: Double(category.colorGreen), blue: Double(category.colorBlue), opacity: 1.0))
                            .frame(width: 70, height: 20)
                        Text("\(category.name ?? "None")")
                    }
                }
            }
            Spacer()
            Text("\(expence.price, specifier: "%.2f")")
                .foregroundColor(.red)
            Text("\(expence.currency ?? "None")")
        }
    }
}

/*struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView()
    }
}*/
