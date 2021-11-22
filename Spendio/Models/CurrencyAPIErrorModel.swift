//
//  CurrencyErrorModel.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-22.
//

import Foundation

// Got the idea from https://www.youtube.com/watch?v=dpmy-msRlCA - 22/11/2021
enum CurrencyAPIError: Error, LocalizedError {
    case invalidURL, badRequest, decode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .badRequest:
            return NSLocalizedString("Currency rate data couldn't be recieved", comment: "")
        case .decode:
            return NSLocalizedString("Currency rate data couldn't be decoded", comment: "")
        }
    }
}

struct CurrencyAPIErrorModel: Identifiable {
    let id = UUID()
    let error: CurrencyAPIError
}
