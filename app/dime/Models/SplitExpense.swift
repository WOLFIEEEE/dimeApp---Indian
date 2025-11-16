//
//  SplitExpense.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

struct SplitExpense: Codable, Identifiable, Hashable {
    let id: UUID
    var title: String
    var totalAmount: Double
    var paidBy: String // Name of person who paid
    var splitWith: [SplitPerson]
    var date: Date
    var settled: Bool
    var category: String? // Optional category
    
    init(id: UUID = UUID(), title: String, totalAmount: Double, paidBy: String, splitWith: [SplitPerson], date: Date = Date(), settled: Bool = false, category: String? = nil) {
        self.id = id
        self.title = title
        self.totalAmount = totalAmount
        self.paidBy = paidBy
        self.splitWith = splitWith
        self.date = date
        self.settled = settled
        self.category = category
    }
    
    var totalOwed: Double {
        splitWith.filter { !$0.settled }.reduce(0) { $0 + $1.owesAmount }
    }
    
    var totalSettled: Double {
        splitWith.filter { $0.settled }.reduce(0) { $0 + $1.owesAmount }
    }
}

struct SplitPerson: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String
    var owesAmount: Double
    var settled: Bool
    var settledDate: Date?
    
    init(id: UUID = UUID(), name: String, owesAmount: Double, settled: Bool = false, settledDate: Date? = nil) {
        self.id = id
        self.name = name
        self.owesAmount = owesAmount
        self.settled = settled
        self.settledDate = settledDate
    }
}

class SplitExpenseManager: ObservableObject {
    @Published var splitExpenses: [SplitExpense] = []
    
    private let userDefaultsKey = "splitExpenses"
    
    init() {
        load()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(splitExpenses) {
            UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func load() {
        if let data = UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([SplitExpense].self, from: data) {
            splitExpenses = decoded
        }
    }
    
    func addExpense(_ expense: SplitExpense) {
        splitExpenses.append(expense)
        save()
    }
    
    func updateExpense(_ expense: SplitExpense) {
        if let index = splitExpenses.firstIndex(where: { $0.id == expense.id }) {
            splitExpenses[index] = expense
            save()
        }
    }
    
    func deleteExpense(_ expense: SplitExpense) {
        splitExpenses.removeAll { $0.id == expense.id }
        save()
    }
    
    func settlePerson(expenseId: UUID, personId: UUID) {
        if let expenseIndex = splitExpenses.firstIndex(where: { $0.id == expenseId }),
           let personIndex = splitExpenses[expenseIndex].splitWith.firstIndex(where: { $0.id == personId }) {
            splitExpenses[expenseIndex].splitWith[personIndex].settled = true
            splitExpenses[expenseIndex].splitWith[personIndex].settledDate = Date()
            
            // Check if all people settled
            let allSettled = splitExpenses[expenseIndex].splitWith.allSatisfy { $0.settled }
            if allSettled {
                splitExpenses[expenseIndex].settled = true
            }
            save()
        }
    }
}

