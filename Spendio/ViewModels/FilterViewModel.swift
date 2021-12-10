//
//  FilterViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-09.
//

import Foundation

class FilterViewModel: ObservableObject {
    let listCurrencyKey: String = "listCurrency"
    let graphCurrencyKey: String = "graphCurrency"
    
    @Published var listCurrency: String? {
        didSet {
            self.saveListCurrency()
        }
    }
    @Published var graphCurrency: String? {
        didSet {
            self.saveGraphCurrency()
        }
    }
    
    private func saveListCurrency() {
        UserDefaults.standard.set(self.listCurrency, forKey: self.listCurrencyKey)
    }
    
    private func saveGraphCurrency() {
        UserDefaults.standard.set(self.graphCurrency, forKey: self.graphCurrencyKey)
    }
    
    func getListCurrency() {
        self.listCurrency = UserDefaults.standard.string(forKey: self.listCurrencyKey)
    }
    
    func getGraphCurrency() {
        self.graphCurrency = UserDefaults.standard.string(forKey: self.graphCurrencyKey)
    }
    
    func setListCurrency(selectedCurrency: String) {
        self.listCurrency = selectedCurrency
    }
    
    func setGraphCurrency(selectedCurrency: String) {
        self.graphCurrency = selectedCurrency
    }
}
