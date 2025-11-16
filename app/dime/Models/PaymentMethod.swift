//
//  PaymentMethod.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

enum PaymentMethod: String, CaseIterable, Codable {
    case cash = "Cash"
    case upi = "UPI"
    case card = "Card"
    case wallet = "Wallet"
    case bankTransfer = "Bank Transfer"
    case other = "Other"
    
    var emoji: String {
        switch self {
        case .cash:
            return "💵"
        case .upi:
            return "⚡"
        case .card:
            return "💳"
        case .wallet:
            return "📱"
        case .bankTransfer:
            return "🏦"
        case .other:
            return "💰"
        }
    }
    
    var displayName: String {
        return "\(emoji) \(rawValue)"
    }
}

