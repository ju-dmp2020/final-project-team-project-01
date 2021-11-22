//
//  Expense.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-11-22.
//

import Foundation


class Expense: ObservableObject{
    @Published var title: String = ""
    @Published var cost: Int = 0
    @Published var transactionDate = Date()
    
}
