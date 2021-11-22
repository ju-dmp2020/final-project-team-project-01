//
//  Expenses.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-11-22.
//

import Foundation

class Expenses: ObservableObject{
    @Published var expenses: [Expense] = []
    
    func addExpense(expense: Expense){
        expenses.append(expense)
    }
}
