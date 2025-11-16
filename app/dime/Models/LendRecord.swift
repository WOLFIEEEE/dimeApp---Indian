//
//  LendRecord.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation
import UserNotifications

enum LendType: String, Codable, CaseIterable {
    case lent = "Lent"
    case borrowed = "Borrowed"
    
    var emoji: String {
        switch self {
        case .lent:
            return "➡️"
        case .borrowed:
            return "⬅️"
        }
    }
}

struct LendRecord: Codable, Identifiable, Hashable {
    let id: UUID
    var personName: String
    var amount: Double
    var date: Date
    var dueDate: Date?
    var type: LendType
    var settled: Bool
    var settledDate: Date?
    var note: String
    var reminderScheduled: Bool
    
    init(id: UUID = UUID(), personName: String, amount: Double, date: Date = Date(), dueDate: Date? = nil, type: LendType, settled: Bool = false, settledDate: Date? = nil, note: String = "", reminderScheduled: Bool = false) {
        self.id = id
        self.personName = personName
        self.amount = amount
        self.date = date
        self.dueDate = dueDate
        self.type = type
        self.settled = settled
        self.settledDate = settledDate
        self.note = note
        self.reminderScheduled = reminderScheduled
    }
    
    var isOverdue: Bool {
        guard let dueDate = dueDate, !settled else { return false }
        return dueDate < Date()
    }
    
    var daysUntilDue: Int? {
        guard let dueDate = dueDate, !settled else { return nil }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let due = calendar.startOfDay(for: dueDate)
        let components = calendar.dateComponents([.day], from: today, to: due)
        return components.day
    }
}

class LendingManager: ObservableObject {
    @Published var lendRecords: [LendRecord] = []
    
    private let userDefaultsKey = "lendRecords"
    
    init() {
        load()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(lendRecords) {
            UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func load() {
        if let data = UserDefaults(suiteName: "group.com.rafaelsoh.dime")?.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([LendRecord].self, from: data) {
            lendRecords = decoded
        }
    }
    
    func addRecord(_ record: LendRecord) {
        lendRecords.append(record)
        save()
        
        // Schedule reminder if due date is set
        if record.dueDate != nil {
            scheduleReminder(for: record)
        }
    }
    
    func updateRecord(_ record: LendRecord) {
        if let index = lendRecords.firstIndex(where: { $0.id == record.id }) {
            lendRecords[index] = record
            save()
        }
    }
    
    func deleteRecord(_ record: LendRecord) {
        // Cancel notification
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [record.id.uuidString])
        lendRecords.removeAll { $0.id == record.id }
        save()
    }
    
    func settleRecord(id: UUID) {
        if let index = lendRecords.firstIndex(where: { $0.id == id }) {
            lendRecords[index].settled = true
            lendRecords[index].settledDate = Date()
            // Cancel notification
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            save()
        }
    }
    
    func scheduleReminder(for record: LendRecord) {
        guard let dueDate = record.dueDate, !record.settled else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Payment Reminder"
        
        if record.type == .lent {
            content.body = "₹\(record.amount) from \(record.personName) is due today"
        } else {
            content.body = "₹\(record.amount) to \(record.personName) is due today"
        }
        
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: record.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    var totalLent: Double {
        lendRecords.filter { $0.type == .lent && !$0.settled }.reduce(0) { $0 + $1.amount }
    }
    
    var totalBorrowed: Double {
        lendRecords.filter { $0.type == .borrowed && !$0.settled }.reduce(0) { $0 + $1.amount }
    }
}

