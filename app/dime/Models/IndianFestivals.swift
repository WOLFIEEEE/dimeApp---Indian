//
//  IndianFestivals.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

struct Festival: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
    let date: Date
    let reminderDays: Int // Remind X days before
    
    var daysUntil: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let festivalDay = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: today, to: festivalDay)
        return components.day ?? 0
    }
}

class FestivalCalendar {
    /// Helper to create date
    private static func date(_ day: Int, _ month: Int, _ year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// 2025 Festival Calendar
    static let festivals2025: [Festival] = [
        Festival(name: "Makar Sankranti", emoji: "🪁", date: date(14, 1, 2025), reminderDays: 7),
        Festival(name: "Republic Day", emoji: "🇮🇳", date: date(26, 1, 2025), reminderDays: 3),
        Festival(name: "Holi", emoji: "🎨", date: date(14, 3, 2025), reminderDays: 7),
        Festival(name: "Eid ul-Fitr", emoji: "🌙", date: date(31, 3, 2025), reminderDays: 7),
        Festival(name: "Ram Navami", emoji: "🏹", date: date(6, 4, 2025), reminderDays: 5),
        Festival(name: "Mahavir Jayanti", emoji: "🙏", date: date(10, 4, 2025), reminderDays: 5),
        Festival(name: "Good Friday", emoji: "✝️", date: date(18, 4, 2025), reminderDays: 5),
        Festival(name: "Buddha Purnima", emoji: "☸️", date: date(12, 5, 2025), reminderDays: 5),
        Festival(name: "Eid ul-Adha", emoji: "🐏", date: date(7, 6, 2025), reminderDays: 7),
        Festival(name: "Rath Yatra", emoji: "🛕", date: date(27, 6, 2025), reminderDays: 5),
        Festival(name: "Muharram", emoji: "🌙", date: date(6, 7, 2025), reminderDays: 5),
        Festival(name: "Raksha Bandhan", emoji: "🎗️", date: date(9, 8, 2025), reminderDays: 7),
        Festival(name: "Independence Day", emoji: "🇮🇳", date: date(15, 8, 2025), reminderDays: 3),
        Festival(name: "Janmashtami", emoji: "🪈", date: date(16, 8, 2025), reminderDays: 7),
        Festival(name: "Ganesh Chaturthi", emoji: "🐘", date: date(27, 8, 2025), reminderDays: 7),
        Festival(name: "Onam", emoji: "🌺", date: date(5, 9, 2025), reminderDays: 7),
        Festival(name: "Dussehra", emoji: "🏹", date: date(2, 10, 2025), reminderDays: 10),
        Festival(name: "Gandhi Jayanti", emoji: "🕊️", date: date(2, 10, 2025), reminderDays: 3),
        Festival(name: "Diwali", emoji: "🪔", date: date(20, 10, 2025), reminderDays: 15),
        Festival(name: "Bhai Dooj", emoji: "👫", date: date(22, 10, 2025), reminderDays: 7),
        Festival(name: "Guru Nanak Jayanti", emoji: "☬", date: date(5, 11, 2025), reminderDays: 7),
        Festival(name: "Christmas", emoji: "🎄", date: date(25, 12, 2025), reminderDays: 10)
    ]
    
    /// 2026 Festival Calendar (add as needed)
    static let festivals2026: [Festival] = [
        Festival(name: "Makar Sankranti", emoji: "🪁", date: date(14, 1, 2026), reminderDays: 7),
        Festival(name: "Republic Day", emoji: "🇮🇳", date: date(26, 1, 2026), reminderDays: 3),
        // Add more 2026 festivals as needed
    ]
    
    /// Get all festivals for current year
    static var currentYearFestivals: [Festival] {
        let currentYear = Calendar.current.component(.year, from: Date())
        switch currentYear {
        case 2025:
            return festivals2025
        case 2026:
            return festivals2026
        default:
            return festivals2025 // Fallback
        }
    }
    
    /// Get upcoming festivals within specified days
    static func upcoming(within days: Int = 30) -> [Festival] {
        let now = Date()
        let calendar = Calendar.current
        guard let future = calendar.date(byAdding: .day, value: days, to: now) else {
            return []
        }
        
        return currentYearFestivals.filter { festival in
            festival.date > now && festival.date < future
        }.sorted { $0.date < $1.date }
    }
    
    /// Get next upcoming festival
    static var nextFestival: Festival? {
        let now = Date()
        return currentYearFestivals
            .filter { $0.date > now }
            .sorted { $0.date < $1.date }
            .first
    }
}

