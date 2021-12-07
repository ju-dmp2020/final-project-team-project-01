//
//  CoreDataError.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-12-07.
//

import Foundation

enum CoreDataError {
    case saveGeneral, savePermission
}

extension CoreDataError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .saveGeneral:
            return NSLocalizedString("Couldn't save", comment: "")
        case .savePermission:
            return NSLocalizedString("Couldn't save due to permissions", comment: "")
        }
    }
}
