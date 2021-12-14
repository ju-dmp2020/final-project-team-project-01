//
//  Currency.swift
//  Spendio
//
//  Created by Mattias Spångberg on 2021-12-12.
//

import Foundation

enum Currency: String , Equatable, CaseIterable {
    case sek = "SEK"
    case eur = "EUR"
    case usd = "USD"
    case nok = "NOK"
}
