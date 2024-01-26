//
//  ApiResponse.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 26/01/2024.
//

import Foundation

struct TokenResponse: Codable {
    let token: String
}

struct AccountResponse: Codable {
    let currentBalance: Decimal
    let transactions: [Transaction]

    var totalAmount: String {
        return "€\(currentBalance)"
    }
}

struct Transaction: Codable {
    let value: Decimal
    let label: String

    var description: String {
        return label
    }

    var amount: String {
        return "€\(value)"
    }
}
