//
//  MainView.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI
import LocalAuthentication

enum TabScreen {
    case history, recentSpendings, addExpense, categories
}

struct MainView: View {
    @State var selectedTabScreen = TabScreen.recentSpendings
    @StateObject var currencyViewModel = CurrencyViewModel()
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        TabView(selection: $selectedTabScreen) {
            if authenticationViewModel.isUnlocked{
            HistoryView(currencyViewModel: currencyViewModel)
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(TabScreen.history)
            
            RecentSpendingsView(currencyViewModel: currencyViewModel)
                .tabItem {
                    Label("Recent Spendings", image: "Money")
                }
                .tag(TabScreen.recentSpendings)
            
            AddExpenseView(tabScreen: $selectedTabScreen)
                .tabItem {
                    Label("Add Expense", systemImage: "plus")
                }
                .tag(TabScreen.addExpense)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "tag")
                }
                .tag(TabScreen.categories)
            }
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
            authenticationViewModel.authenticate()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
