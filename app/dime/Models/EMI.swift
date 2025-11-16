//
//  EMI.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

struct EMI: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String // "Home Loan", "Car Loan", etc.
    var monthlyAmount: Double
    var startDate: Date
    var totalMonths: Int
    var paidMonths: Int
    var bankName: String
    var interestRate: Double? // Optional
    var emoji: String
    
    init(id: UUID = UUID(), name: String, monthlyAmount: Double, startDate: Date, totalMonths: Int, paidMonths: Int = 0, bankName: String, interestRate: Double? = nil, emoji: String = "💳") {
        self.id = id
        self.name = name
        self.monthlyAmount = monthlyAmount
        self.startDate = startDate
        self.totalMonths = totalMonths
        self.paidMonths = paidMonths
        self.bankName = bankName
        self.interestRate = interestRate
        self.emoji = emoji
    }
    
    var remainingMonths: Int {
        totalMonths - paidMonths
    }
    
    var totalRemaining: Double {
        monthlyAmount * Double(remainingMonths)
    }
    
    var totalPaid: Double {
        monthlyAmount * Double(paidMonths)
    }
    
    var totalAmount: Double {
        monthlyAmount * Double(totalMonths)
    }
    
    var progressPercentage: Double {
        guard totalMonths > 0 else { return 0 }
        return Double(paidMonths) / Double(totalMonths) * 100
    }
    
    var endDate: Date {
        Calendar.current.date(byAdding: .month, value: totalMonths, to: startDate) ?? startDate
    }
}

class EMIManager: ObservableObject {
    @Published var emis: [EMI] = []
    
    private let userDefaultsKey = "emis"
    
    init() {
        load()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(emis) {
            UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func load() {
        if let data = UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([EMI].self, from: data) {
            emis = decoded
        }
    }
    
    func addEMI(_ emi: EMI) {
        emis.append(emi)
        save()
    }
    
    func updateEMI(_ emi: EMI) {
        if let index = emis.firstIndex(where: { $0.id == emi.id }) {
            emis[index] = emi
            save()
        }
    }
    
    func deleteEMI(_ emi: EMI) {
        emis.removeAll { $0.id == emi.id }
        save()
    }
    
    func recordPayment(emiId: UUID) {
        if let index = emis.firstIndex(where: { $0.id == emiId }) {
            if emis[index].paidMonths < emis[index].totalMonths {
                emis[index].paidMonths += 1
                save()
            }
        }
    }
    
    var totalMonthlyEMI: Double {
        emis.filter { $0.remainingMonths > 0 }.reduce(0) { $0 + $1.monthlyAmount }
    }
    
    var totalOutstanding: Double {
        emis.reduce(0) { $0 + $1.totalRemaining }
    }
    
    var activeEMIs: [EMI] {
        emis.filter { $0.remainingMonths > 0 }
    }
}

