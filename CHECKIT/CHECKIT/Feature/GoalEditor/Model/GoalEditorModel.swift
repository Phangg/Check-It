//
//  GoalEditorModel.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

// MARK: - State
protocol GoalEditorModelState: AnyObject {
    var goalTitleText: String { get }
    var selectedDays: [DayInSelector] { get }
    var isSaveButtonActive: Bool { get }
    var isGoalNotificationEnabled: Bool { get }
    var selectedTime: Date { get }
    var showTimePicker: Bool { get }
    var type: GoalEditorType { get }
}

// MARK: - Action
protocol GoalEditorModelAction: AnyObject {
    //
    func update(isGoalNotificationEnabled newValue: Bool)
    func update(showTimePicker newValue: Bool)
    func update(isSaveButtonActive newValue: Bool)
    func update(selectedTime newDate: Date)
    func update(goalTitleText newText: String)
    func update(selectedDays newDays: [DayInSelector])
}
