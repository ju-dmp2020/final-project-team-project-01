//
//  ErrorAlertModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-09.
//

import Foundation

struct ErrorAlertModel: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (() -> Void)?
}
