//
//  FinancialYear.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

extension Date {
    /// Returns the Indian Financial Year dates (April 1 - March 31)
    var financialYear: (start: Date, end: Date) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        
        // Indian FY: April 1 - March 31
        // If current month is Jan-Mar, FY started last year
        // If current month is Apr-Dec, FY started this year
        let fyYear = month >= 4 ? year : year - 1
        
        guard let start = calendar.date(from: DateComponents(
            year: fyYear,
            month: 4,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0
        )),
        let end = calendar.date(from: DateComponents(
            year: fyYear + 1,
            month: 3,
            day: 31,
            hour: 23,
            minute: 59,
            second: 59
        )) else {
            return (self, self)
        }
        
        return (start, end)
    }
    
    /// Returns the FY quarter (Q1, Q2, Q3, Q4)
    var fyQuarter: String {
        let month = Calendar.current.component(.month, from: self)
        switch month {
        case 4...6: return "Q1" // Apr-Jun
        case 7...9: return "Q2" // Jul-Sep
        case 10...12: return "Q3" // Oct-Dec
        default: return "Q4" // Jan-Mar
        }
    }
    
    /// Returns FY string like "FY 2024-25"
    var fyString: String {
        let fy = self.financialYear
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: fy.start)
        let endYear = calendar.component(.year, from: fy.end)
        return "FY \(startYear)-\(String(endYear).suffix(2))"
    }
    
    /// Returns the start and end of current FY quarter
    var fyQuarterRange: (start: Date, end: Date) {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        
        var startMonth: Int
        var endMonth: Int
        var startYear: Int
        var endYear: Int
        
        switch month {
        case 4...6: // Q1
            startMonth = 4
            endMonth = 6
            startYear = year
            endYear = year
        case 7...9: // Q2
            startMonth = 7
            endMonth = 9
            startYear = year
            endYear = year
        case 10...12: // Q3
            startMonth = 10
            endMonth = 12
            startYear = year
            endYear = year
        default: // Q4 (Jan-Mar)
            startMonth = 1
            endMonth = 3
            startYear = year
            endYear = year
        }
        
        guard let start = calendar.date(from: DateComponents(
            year: startYear,
            month: startMonth,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0
        )),
        let lastDay = calendar.range(of: .day, in: .month, for: calendar.date(from: DateComponents(year: endYear, month: endMonth))!)?.count,
        let end = calendar.date(from: DateComponents(
            year: endYear,
            month: endMonth,
            day: lastDay,
            hour: 23,
            minute: 59,
            second: 59
        )) else {
            return (self, self)
        }
        
        return (start, end)
    }
}

