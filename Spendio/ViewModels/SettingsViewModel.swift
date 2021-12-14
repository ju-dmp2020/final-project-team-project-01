//
//  FilterViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-09.
//

import Foundation
import UIKit

class SettingsViewModel: ObservableObject {
    let baseCurrencyKey: String = "baseCurrency"
    let authenticationKey: String = "authentication"
    
    // Will be used inside views and AuthenticationViewModel
    static var shared = SettingsViewModel()
    
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
    
    private init() {
        self.getBaseCurrency()
        self.isAuthenticationEnabled()
        print(self.isAuthenticationEnabled())
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
