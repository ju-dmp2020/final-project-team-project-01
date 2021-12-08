//
//  GraphManager.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-02.
//

import Foundation
import SwiftUICharts
import SwiftUI

struct GraphModel {
    
    let standardLightStyle = ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .blue, end: .purple), textColor: .black, legendTextColor: .black, dropShadowColor: .gray)
    
    let standardDarkStyle = ChartStyle(backgroundColor: .black, accentColor: .blue, gradientColor: GradientColor(start: .blue, end: .purple), textColor: .white, legendTextColor: .white, dropShadowColor: .gray)
    
    
    
    func populateChartData (expenses: [Expense], categories: [Category]) -> [(String, Float)] {
        var chartData:[(String, Float)] = []
            for category in categories{
                var categoryData: [String: Float] = [:]
                categoryData["\(category.name ?? "Unknown")"] = 0
                for expense in expenses {
                    if expense.category?.name == category.name{
                        categoryData["\(String(describing: category.name))"]! += Float(expense.price)
                    }
                }
                let tup = ("\(category.name)", categoryData["\(category.name)"]!)  // it crashes as the category name is nil at startup. FIX!
                chartData.append(tup)
            }
            return chartData
    }
}
