//
//  SampleData.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import Foundation

struct SampleData {
    static let goals: [Goal] = [
        .init(id: UUID(), title: "1 커밋하기", activeDays: [.allDay], notificationEnabled: true, notificationTime: 20, isActive: false, streakCount: 0),
        .init(id: UUID(), title: "30분 러닝하기", activeDays: [.allDay], notificationEnabled: true, notificationTime: 18, isActive: false, streakCount: 19),
        .init(id: UUID(), title: "낮잠 안자기", activeDays: [.allDay], notificationEnabled: false, notificationTime: nil, isActive: true, streakCount: 4),
        .init(id: UUID(), title: "No Coffee", activeDays: [.allDay], notificationEnabled: false, notificationTime: nil, isActive: true, streakCount: 2),
        .init(id: UUID(), title: "일기 작성", activeDays: [.allDay], notificationEnabled: true, notificationTime: 21, isActive: false, streakCount: 0)
    ]
    
    
    static let days: [DayData] = Date
        .range(from: "2024.09.11")
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
