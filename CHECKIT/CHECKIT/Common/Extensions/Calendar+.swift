//
//  Calendar+.swift
//  CHECKIT
//
//  Created by phang on 1/21/25.
//

import Foundation

extension Calendar {
    func isDateInFirstWeek(_ date: Date) -> Bool {
        let day = component(.day, from: date)
        return day <= 4
    }
    
    func isDateInLastWeek(_ date: Date) -> Bool {
        let day = component(.day, from: date)
        let lastDay = range(of: .day, in: .month, for: date)?.last ?? 31
        return (lastDay - 2) <= day
    }
    
    func getDayIndexOfWeek(from date: Date) -> Int {
        let weekdayIndex = component(.weekday, from: date) // 1: 일요일, 2: 월요일 ...
        let index = weekdayIndex - 1
        // 반환 시, 1: 월요일, 2: 화요일 ... 7: 일요일
        return (index == 0) ? 7 : index
    }
    
    func getWeekday(from date: Date) -> Weekday {
        let weekdayIndex = component(.weekday, from: date)
        return Weekday.allCases[weekdayIndex - 1]
    }
    
    func getMonth(from date: Date) -> Month {
        let month = component(.month, from: date)
        return Month.getMonth(for: month)
    }
    
    func getNextMonth(from date: Date) -> Month {
        let nextMonthDate = self.date(byAdding: .month, value: 1, to: date)!
        let nextMonth = component(.month, from: nextMonthDate)
        return Month.getMonth(for: nextMonth)
    }
}
