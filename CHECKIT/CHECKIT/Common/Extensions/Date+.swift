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
}
