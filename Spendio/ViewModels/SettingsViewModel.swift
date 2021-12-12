//
//  FilterViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-09.
//

import Foundation

class SettingsViewModel: ObservableObject {
    let baseCurrencyKey: String = "baseCurrency"
    let authenticationKey: String = "authentication"
    
    @Published var useAuthentication: Bool = false {
        didSet {
            self.saveAuthentication()
        }
    }
    
    @Published var baseCurrency: String? {
        didSet {
            self.saveBaseCurrency()
        }
    }
    
    private func saveBaseCurrency() {
        UserDefaults.standard.set(self.baseCurrency, forKey: self.baseCurrencyKey)
    }
    
    private func saveAuthentication() {
        UserDefaults.standard.set(self.useAuthentication, forKey: self.authenticationKey)
    }
    
    func getBaseCurrency() {
        self.baseCurrency = UserDefaults.standard.string(forKey: self.baseCurrencyKey)
    }
    
    func isAuthenticationEnabled() {
        self.useAuthentication = UserDefaults.standard.bool(forKey: self.authenticationKey)
    }
    
    func setBaseCurrency(selectedCurrency: String) {
        self.baseCurrency = selectedCurrency
    }
    
    func toggleAuthentication() {
        self.useAuthentication.toggle()
    }
}
