//
//  DayData.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import Foundation

struct DayData: Hashable {
    let date: Date
    let dayOfMonth: Int                      // 16
    let completionLevel: CompletionLevel
    let goalTitles: [String]                 // 해당 날짜에 존재했던 목표들
}
