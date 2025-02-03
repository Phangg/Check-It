//
//  GoalEditorModelImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

final class GoalEditorModelImp: ObservableObject, GoalEditorModelState {
    @Published private(set) var goalTitleText: String
    @Published private(set) var selectedDays: [DayInSelector]
    @Published private(set) var isSaveButtonActive: Bool
    @Published private(set) var isGoalNotificationEnabled: Bool
    @Published private(set) var selectedTime: Date
    @Published private(set) var showTimePicker: Bool = false
    //
    let type: GoalEditorType

    init(
        type: GoalEditorType,
        goalTitleText: String = "",
        selectedDays: [DayInSelector] = DayInSelector.defaultDays,
        isGoalNotificationEnabled: Bool = true,
        selectedTime: Date = Calendar.current.date(from: DateComponents(hour: 18, minute: 0)) ?? Date()
    ) {
        self.type = type
        //
        switch type {
            //
        case .add:
            self.goalTitleText = goalTitleText
            self.selectedDays = selectedDays
            self.isSaveButtonActive = false
            self.isGoalNotificationEnabled = isGoalNotificationEnabled
            self.selectedTime = selectedTime
            //
        case .edit(let goal):
            self.goalTitleText = goal.title
            self.selectedDays = goal.convertToDaySelectors()
            self.isSaveButtonActive = true
            self.isGoalNotificationEnabled = goal.notificationEnabled
            self.selectedTime = goal.notificationTime ?? Date()
        }
    }
}

// MARK: - Action
extension GoalEditorModelImp: GoalEditorModelAction {
    //
    func update(isGoalNotificationEnabled newValue: Bool) {
        isGoalNotificationEnabled = newValue
    }
    
    func update(showTimePicker newValue: Bool) {
        showTimePicker = newValue
    }
    
    func update(isSaveButtonActive newValue: Bool) {
        isSaveButtonActive = newValue
    }
    
    func update(selectedTime newDate: Date) {
        selectedTime = newDate
    }

    func update(goalTitleText newText: String) {
        goalTitleText = newText
    }
    
    func update(selectedDays newDays: [DayInSelector]) {
        selectedDays = newDays
    }
}
