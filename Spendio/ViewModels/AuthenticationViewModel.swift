//
//  AuthenticationViewModel.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-10.
//

import Foundation
import LocalAuthentication


class AuthenticationViewModel: ObservableObject {
    @Published var isUnlocked = false
    
    // https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui - 09/12/2021
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please authenticate yourself"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    self.isUnlocked = true
                } else {
                    // there was a problem
                    print("123")
                }
            }
        }
    }
}
