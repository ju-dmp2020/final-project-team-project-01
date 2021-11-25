//
//  CurrencyErrorModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

// Got the idea from https://www.youtube.com/watch?v=dpmy-msRlCA - 22/11/2021
enum CurrencyAPIError {
    case invalidURL, badRequest, decode
    
}

struct CurrencyAPIErrorModel: Identifiable {
    let id = UUID()
    let error: CurrencyAPIError
}

extension CurrencyAPIError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .badRequest:
            return NSLocalizedString("Currency data couldn't be recieved", comment: "")
        case .decode:
            return NSLocalizedString("Currency data couldn't be decoded", comment: "")
        }
    }
}
