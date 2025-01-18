//
//  DateFormat.swift
//  CHECKIT
//
//  Created by phang on 1/15/25.
//

import Foundation

struct DateFormat {
    private static let yearDotMonthDotDay = "yyyy.MM.dd"
    private static let monthInEnglishFormat = "MMM"
    
    static func dateToYearDotMonthDotDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = yearDotMonthDotDay
        return dateFormatter.string(from: date)
    }
    
    static func dateToMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = monthInEnglishFormat
        return dateFormatter.string(from: date)
    }
}
