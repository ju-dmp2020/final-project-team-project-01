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
            for expense in expenses {
                if expense.category?.name == category.name{
                    let tup = ("\(category.name ?? "unknown")", Float(expense.price))
                    chartData.append(tup)
                }
            }
        }
        return chartData
    }
    
    
}
