//
//  MainModel.swift
//  CHECKIT
//
//  Created by phang on 2/3/25.
//

import SwiftUI

// MARK: - State
protocol MainModelState: AnyObject {
    var sampleCalendarData: [DayData] { get }
    var sampleGoalData: [Goal] { get }
    var showAddGoalSheet: Bool { get }
    var showSettingSheet: Bool { get }
    var showEditGoalSheet: Bool { get }
    var showDeleteGoalAlert: Bool { get }
    var selectedGoal: Goal? { get }
    var calendarRows: [GridItem] { get }
}

// MARK: - Action
protocol MainModelAction: AnyObject {
    func update(showAddGoalSheet newValue: Bool)
    func update(showEditGoalSheet newValue: Bool)
    func update(showSettingSheet newValue: Bool)
    func update(showDeleteGoalAlert newValue: Bool)
    func update(selectedGoal newGoal: Goal?)
    func update(sampleGoalData newGoalData: [Goal])
}
