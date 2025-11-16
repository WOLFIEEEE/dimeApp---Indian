//
//  IndianNumberFormat.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

extension Double {
    /// Converts number to Indian format with Lakh/Crore
    /// Example: 1000000 -> "10,00,000"
    func toIndianFormat(showDecimals: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_IN")
        
        if showDecimals {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        } else {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        }
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    /// Converts to compact Indian format (10L, 1.5Cr, etc.)
    func toIndianCompact() -> String {
        let absValue = abs(self)
        
        if absValue >= 10000000 { // 1 Crore
            let crores = self / 10000000
            if crores.truncatingRemainder(dividingBy: 1) == 0 {
                return String(format: "%.0fCr", crores)
            } else {
                return String(format: "%.1fCr", crores)
            }
        } else if absValue >= 100000 { // 1 Lakh
            let lakhs = self / 100000
            if lakhs.truncatingRemainder(dividingBy: 1) == 0 {
                return String(format: "%.0fL", lakhs)
            } else {
                return String(format: "%.1fL", lakhs)
            }
        } else if absValue >= 1000 { // 1 Thousand
            let thousands = self / 1000
            if thousands.truncatingRemainder(dividingBy: 1) == 0 {
                return String(format: "%.0fK", thousands)
            } else {
                return String(format: "%.1fK", thousands)
            }
        }
        
        // For numbers less than 1000
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.2f", self)
        }
    }
    
    /// Formats currency with Indian number system
    func toIndianCurrency(currencySymbol: String = "₹", compact: Bool = false, showDecimals: Bool = true) -> String {
        if compact {
            return "\(currencySymbol)\(self.toIndianCompact())"
        } else {
            return "\(currencySymbol)\(self.toIndianFormat(showDecimals: showDecimals))"
        }
    }
}

extension Int {
    /// Converts Int to Indian format
    func toIndianFormat() -> String {
        return Double(self).toIndianFormat(showDecimals: false)
    }
    
    /// Converts Int to compact Indian format
    func toIndianCompact() -> String {
        return Double(self).toIndianCompact()
    }
}

