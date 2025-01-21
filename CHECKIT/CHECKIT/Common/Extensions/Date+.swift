//
//  Date+.swift
//  CHECKIT
//
//  Created by phang on 1/18/25.
//

import SwiftUI

extension Date {
    // 시작 날짜와 종료 날짜 사이의 모든 날짜를 반환
    static func range(
        from start: String,
        to end: String = DateFormat.dateToYearDotMonthDotDay(Date()),
        format: String = "yyyy.MM.dd"
    ) -> [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        // start & end : String -> Date
        guard let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: end)
        else { return [] }
        //
        var dates = [startDate]
        var currentDate = startDate
        let calendar = Calendar.current
        while let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate),
              nextDate <= endDate {
            dates.append(nextDate)
            currentDate = nextDate
        }
        return dates
    }
    
    // 해당 날짜가 첫째주인지 아닌지 확인해서, 첫째주인 경우 해당 월을 반환 & 유저의 앱 시작 날이라면, 무조건 반환
    static func checkFirstWeekMonth(
        for date: Date,
        isStartDay: Bool
    ) -> Month? {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        // 유저의 앱 시작 날 조건: Month 반환
        // 첫째 주 조건: 1~4일에 해당
        if isStartDay || day <= 4 {
            return Month.getMonth(for: month)
        }
        // 월의 마지막 2~3일에 해당 -> 다음 달 반환
        let lastDay = calendar.range(of: .day, in: .month, for: date)?.last ?? 31
        if (lastDay - 2) <= day {
            let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: date)!
            let nextMonth = calendar.component(.month, from: nextMonthDate)
            return Month.getMonth(for: nextMonth)
        }
        // 첫째 주가 아님
        return nil
    }
    
    // 주어진 날짜의 요일 Index를 반환
    static func getDayIndexOfWeek(
        for date: Date
    ) -> Int {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: date) // 1: 일요일, 2: 월요일 ...
        let index = weekdayIndex - 1
        // 반환 시, 1: 월요일, 2: 화요일 ... 7: 일요일
        return (index == 0) ? 7 : index
    }
    
    // 주어진 날짜의 요일을 반환
    static func getWeekday(
        for date: Date
    ) -> Weekday {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: date)
        return Weekday.allCases[weekdayIndex - 1]
    }
    
    // 주어진 날짜의 달을 반환
    static func getMonth(
        for date: Date
    ) -> Month {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        return Month.getMonth(for: month)
    }
}
