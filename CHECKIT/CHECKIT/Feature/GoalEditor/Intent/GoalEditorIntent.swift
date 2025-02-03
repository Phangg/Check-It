//
//  GoalEditorIntent.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

protocol GoalEditorIntent: AnyObject {
    func validateSaveButton(goalTitleText: String, selectedDays: [DayInSelector])
    func openTimePicker()
    //
    func update(isGoalNotificationEnabled newValue: Bool)
    func update(showTimePicker newValue: Bool)
    func update(isSaveButtonActive newValue: Bool)
    func update(selectedTime newDate: Date)
    func update(goalTitleText newText: String)
    func update(selectedDays newDays: [DayInSelector])
}
