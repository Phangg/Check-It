//
//  GoalEditorView.swift
//  CHECKIT
//
//  Created by phang on 1/30/25.
//

import SwiftUI

struct GoalEditorView: View {
    private let type: GoalEditorType
    
    init(
        _ type: GoalEditorType
    ) {
        self.type = type
    }

    var body: some View {
        switch type {
        // Goal 생성
        case .add:
            GoalEditorContent()
        // Goal 추가
        case .edit(let goal):
            GoalEditorContent(
                goalTitleText: goal.title,
                selectedDays: goal.convertToDaySelectors(),
                isGoalNotificationEnabled: goal.notificationEnabled,
                selectedTime: goal.notificationTime ?? Date()
            )
        }
    }
}
