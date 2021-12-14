//
//  ViewExtensions.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-01.
//

import Foundation
import SwiftUI

extension View {
    
    func centerHorizontally() -> some View {
         return HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    func withErrorHandling() -> some View {
        modifier(ErrorAlertViewModifier())
    }
}
