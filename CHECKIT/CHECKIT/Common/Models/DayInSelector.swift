//
//  DayInSelector.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

struct DayInSelector: Hashable {
    let day: Weekday
    var isSelected: Bool
}

extension DayInSelector {
    static var defaultDays: [DayInSelector] = [
        .init(day: .allDay, isSelected: true),
        .init(day: .monday, isSelected: true),
        .init(day: .tuesday, isSelected: true),
        .init(day: .wednesday, isSelected: true),
        .init(day: .thursday, isSelected: true),
        .init(day: .friday, isSelected: true),
        .init(day: .saturday, isSelected: true),
        .init(day: .sunday, isSelected: true)
    ]
}
