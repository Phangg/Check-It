//
//  SampleData.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import Foundation

struct SampleData {
    static let goals: [Goal] = [
        .init(title: "1 커밋하기", activeDays: [.allDay], notificationEnabled: true, notificationTime: Calendar.current.date(from: DateComponents(hour: 20, minute: 0)), isActive: false, streakCount: 0),
        .init(title: "30분 러닝하기", activeDays: [.monday, .wednesday, .friday], notificationEnabled: true, notificationTime: Calendar.current.date(from: DateComponents(hour: 18, minute: 0)), isActive: false, streakCount: 19),
        .init(title: "낮잠 안자기", activeDays: [.monday, .tuesday, .wednesday, .thursday, .friday], notificationEnabled: false, notificationTime: nil, isActive: true, streakCount: 4),
        .init(title: "No Coffee", activeDays: [.saturday, .sunday], notificationEnabled: false, notificationTime: nil, isActive: true, streakCount: 2),
        .init(title: "일기 작성", activeDays: [.allDay], notificationEnabled: true, notificationTime: Calendar.current.date(from: DateComponents(hour: 21, minute: 0)), isActive: false, streakCount: 0)
    ]
    
    
    static let days: [DayData] = Date
        .range(from: "2024.09.04")
        .map { date in
            let calendar = Calendar.current
            let dayOfMonth = calendar.component(.day, from: date)
            let completionLevel = CompletionLevel.allCases.randomElement()!
            let goalTitles = ["test"]
            
            return DayData(
                date: date,
                dayOfMonth: dayOfMonth,
                completionLevel: completionLevel,
                goalTitles: goalTitles
            )
        }
}
