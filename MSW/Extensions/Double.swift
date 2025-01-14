//
//  Double.swift
//  MSW
//
//  Created by Tom Tiedtke on 21.12.24.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func toPercentString() -> String {
        guard let numberAsString = numberFormatter.string(for: self) else { return "" }
        return numberAsString + "%"
    }
    
    func toAmountString() -> String {
        let formatter = NumberFormatter()
              formatter.minimumFractionDigits = 0
              formatter.maximumFractionDigits = 2
              formatter.numberStyle = .decimal
              //return "TOMTEST"
              return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
