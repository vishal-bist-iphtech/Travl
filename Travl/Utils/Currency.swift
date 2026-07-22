//
//  Currency.swift
//  Travl
//
//  Created by iPHTech 34 on 22/07/26.
//

import Foundation

extension String {

    var currencySymbol: String {

        switch uppercased() {

        case "INR": return "₹"
        case "USD": return "$"
        case "EUR": return "€"
        case "GBP": return "£"
        case "JPY": return "¥"
        case "AUD": return "A$"
        case "CAD": return "C$"
        case "SGD": return "S$"
        case "AED": return "د.إ"
        case "CHF": return "CHF"

        default:
            return self
        }
    }
}
