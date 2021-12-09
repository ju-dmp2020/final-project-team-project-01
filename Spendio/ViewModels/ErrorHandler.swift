//
//  ErrorHandlerViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-06.
//

import Foundation

// https://www.ralfebert.com/swiftui/generic-error-handling/ - 16/12/2021

class ErrorHandler: ObservableObject {
    @Published var currentAlert: ErrorAlertModel? = nil
    
    static let shared = ErrorHandler()
    
    func handle(error: Error) {
        DispatchQueue.main.async {
            self.currentAlert = ErrorAlertModel(message: error.localizedDescription)
        }
    }
}
