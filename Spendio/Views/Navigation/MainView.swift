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
    @StateObject var expensesArray = Expenses()
    @StateObject var currencyViewModel = CurrencyViewModel()
    var body: some View {
        TabView(selection: $selectedTabScreen) {
            HistoryView(expensesArray: expensesArray, currencyVM: currencyViewModel)
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(TabScreen.History)
            
            RecentSpendingsView(expensesArray: expensesArray, currencyVM: currencyViewModel)
                .tabItem {
                    Label("Recent Spendings", image: "Money")
                }
                .tag(TabScreen.RecentSpendings)
            
            AddExpenseView(tabScreen: $selectedTabScreen, expensesArray: expensesArray)
                .tabItem {
                    Label("Add Expense", systemImage: "plus")
                }
                .tag(TabScreen.AddExpense)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "tag")
                }
                .tag(TabScreen.Categories)
        }
        .onAppear {
            // https://nemecek.be/blog/127/how-to-disable-automatic-transparent-tabbar-in-ios-15 - 19/11/2021
            // Disable tabview bar transparency
            if #available(iOS 13.0, *) {
                let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().standardAppearance = tabBarAppearance
                
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
            }
            // Testing api
            // Fetch function will be used in History and Recent view
            Task {
                await currencyViewModel.fetch(baseCurrency: "sek")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
