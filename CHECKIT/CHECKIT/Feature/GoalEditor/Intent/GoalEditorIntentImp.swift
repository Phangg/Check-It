//
//  GoalEditorIntentImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

final class GoalEditorIntentImp {
    // Model
    private weak var model: GoalEditorModelAction?
        
    init(
        model: GoalEditorModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension GoalEditorIntentImp: GoalEditorIntent {
    func validateSaveButton(goalTitleText: String, selectedDays: [DayInSelector]) {
        model?.update(
            isSaveButtonActive: !goalTitleText.isEmpty &&
            selectedDays.contains(where: { $0.isSelected })
        )
    }
    
    func openTimePicker() {
        model?.update(showTimePicker: true)
    }

    //
    func update(isGoalNotificationEnabled newValue: Bool) {
        model?.update(isGoalNotificationEnabled: newValue)
    }
    
    func update(showTimePicker newValue: Bool) {
        model?.update(showTimePicker: newValue)
    }
    
    func update(isSaveButtonActive newValue: Bool) {
        model?.update(isSaveButtonActive: newValue)
    }
    
    func update(selectedTime newDate: Date) {
        model?.update(selectedTime: newDate)
    }
    
    func update(goalTitleText newText: String) {
        model?.update(goalTitleText: newText)
    }
    
    func update(selectedDays newDays: [DayInSelector]) {
        model?.update(selectedDays: newDays)
    }
}
