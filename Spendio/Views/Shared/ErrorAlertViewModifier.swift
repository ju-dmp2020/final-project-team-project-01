//
//  ErrorAlertViewModifier.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-06.
//

import Foundation
import SwiftUI

// https://www.ralfebert.com/swiftui/generic-error-handling/ - 16/12/2021

struct ErrorAlertViewModifier: ViewModifier {
    @StateObject var errorHandler = ErrorHandler()
    
    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandler)
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandler.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Whoops, an error occurred"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}
