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
    
    //
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // Date -> "yyyy.MM.dd"
    static func dateToYearDotMonthDotDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = yearDotMonthDotDay
        return dateFormatter.string(from: date)
    }
    
    // Date -> "MMM" (en)
    static func dateToMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = monthInEnglishFormat
        return dateFormatter.string(from: date)
    }
}
