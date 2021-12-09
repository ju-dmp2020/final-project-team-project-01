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
        var tempChartData:[(String, Float)] = [] // the graph only takes an array of tuples so this is a temporary tuple array that will overwrite chartData in the end.
        var data: [String: Float] = [:]// this is a dictionary that stores the data and will be added to chart data as a tuple.
        var names:[String] = []
        for expense in expenses {
            if let category = expense.category{
                if data[category.name ?? "no name"] == nil{
                    data[category.name ?? "no name"] = Float(expense.price)
                    names.append(category.name ?? "Unknown")
                }
                else{
                    data[category.name ?? "Unknown"]! += Float(expense.price)
                }
            } else {
                if data["Uncategorised"] == nil{
                    data["Uncategorised"] = Float(expense.price)
                    names.append("Uncategorised")
                }
                else {
                    data["Uncategorised"]! += Float(expense.price)
                }
                
            }
        }
        for name in names{
            let tup = ("\(name)", data["\(name)"] ?? Float(0.0))  // it crashes as the category name is nil at startup. FIX!
            tempChartData.append(tup)
        }
        
        self.chartData = tempChartData
    }
}
