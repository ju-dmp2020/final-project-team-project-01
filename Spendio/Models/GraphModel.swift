//
//  GraphManager.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-02.
//

import Foundation
import SwiftUICharts
import SwiftUI

class GraphModel {
    @Published var chartData: [(String, Float)] = []
    
    let standardLightStyle = ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .blue, end: .purple), textColor: .black, legendTextColor: .black, dropShadowColor: .gray)
    
    let standardDarkStyle = ChartStyle(backgroundColor: .black, accentColor: .blue, gradientColor: GradientColor(start: .blue, end: .purple), textColor: .white, legendTextColor: .white, dropShadowColor: .gray)
    
    
    
    func populateChartData (expenses: [Expense]){
        var tempChartData:[(String, Float)] = []
        var categoryData: [String: Float] = [:]
        var names:[String] = []
        for expense in expenses {
            if let category = expense.category{
                if categoryData[category.name ?? "no name"] == nil{
                    categoryData[category.name ?? "no name"] = Float(expense.price)
                    names.append(category.name ?? "Unknown")
                }
                else{
                    categoryData[category.name ?? "Unknown"]! += Float(expense.price)
                }
            }
        }
        for name in names{
            let tup = ("\(name)", categoryData["\(name)"] ?? Float(0.0))  // it crashes as the category name is nil at startup. FIX!
            tempChartData.append(tup)
        }
        
        self.chartData = tempChartData
    }
}
