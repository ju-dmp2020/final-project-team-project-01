//
//  MainView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

enum TabScreen {
    case History, RecentSpendings, AddExpense, Categories
}

struct MainView: View {
    @State var selectedTabScreen = TabScreen.RecentSpendings
    
    var body: some View {
        TabView(selection: $selectedTabScreen) {
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(TabScreen.History)
            
            RecentSpendingsView()
                .tabItem {
                    Label("Recent Spendings", systemImage: "eurosign.circle")
                }
                .tag(TabScreen.RecentSpendings)
            
            AddExpenseView()
                .tabItem {
                    Label("Add Expense", systemImage: "plus")
                }
                .tag(TabScreen.AddExpense)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "tag")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
