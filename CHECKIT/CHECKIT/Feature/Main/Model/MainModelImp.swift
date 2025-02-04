//
//  MainModelImp.swift
//  CHECKIT
//
//  Created by phang on 2/3/25.
//

import SwiftUI

final class MainModelImp: ObservableObject, MainModelState {
    @Published private(set) var sampleCalendarData: [DayData] = SampleData.days
    @Published private(set) var sampleGoalData: [Goal] = SampleData.goals
    @Published private(set) var showAddGoalSheet: Bool = false
    @Published private(set) var showSettingSheet: Bool = false
    //
    @Published private(set) var showEditGoalSheet: Bool = false
    @Published private(set) var showDeleteGoalAlert: Bool = false
    @Published private(set) var selectedGoal: Goal? = nil
    //
    let calendarRows = Array(
        repeating: GridItem(.flexible(), spacing: ViewValues.Padding.small),
        count: 7 + 1
    )
}

// MARK: - Action
extension MainModelImp: MainModelAction {
    //
    func update(showAddGoalSheet newValue: Bool) {
        showAddGoalSheet = newValue
    }
    
    func update(showEditGoalSheet newValue: Bool) {
        showEditGoalSheet = newValue
    }
    
    func update(showSettingSheet newValue: Bool) {
        showSettingSheet = newValue
    }
    
    func update(showDeleteGoalAlert newValue: Bool) {
        showDeleteGoalAlert = newValue
    }
    
    func update(selectedGoal newGoal: Goal?) {
        selectedGoal = newGoal
    }
    
    func update(sampleGoalData newGoalData: [Goal]) {
        sampleGoalData = newGoalData
    }
}
