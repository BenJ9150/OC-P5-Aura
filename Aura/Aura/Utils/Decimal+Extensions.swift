//
//  Decimal+Extensions.swift
//  Aura
//
//  Created by Benjamin LEFRANCOIS on 09/02/2024.
//

import Foundation

extension Decimal {

    func formattedEuroString(withSignLeading: Bool = false) -> String {
        // Formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."

        // Check if need to put sign in leading
        if !withSignLeading {
            if let formattedString = formatter.string(from: NSDecimalNumber(decimal: self)) {
                return "€\(formattedString)"
            }
        }
        
        // change sign position
        guard let formattedString = formatter.string(from: NSDecimalNumber(decimal: abs(self))) else {
            return "€\(self)"
        }
        
        if self < 0 {
            return "-€\(formattedString)"
        }
        return "+€\(formattedString)"
    }
}
