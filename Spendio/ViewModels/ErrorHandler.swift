//
//  ErrorHandlerViewModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-06.
//

import Foundation

// https://www.ralfebert.com/swiftui/generic-error-handling/ - 16/12/2021

struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}

class ErrorHandler: ObservableObject {
    @Published var currentAlert: ErrorAlert? = nil
    
    func handle(error: Error) {
        DispatchQueue.main.async {
            self.currentAlert = ErrorAlert(message: error.localizedDescription)
        }
    }
}
