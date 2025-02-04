//
//  MainIntent.swift
//  CHECKIT
//
//  Created by phang on 2/3/25.
//

import Foundation

protocol MainIntent: AnyObject {
    func openGoalEditor(type: GoalEditorType)
    func openSettingSheet()
    func resetSelectedGoal()
    func handleTapDeleteButton(for goal: Goal)
    //
    func update(showAddGoalSheet newValue: Bool)
    func update(showEditGoalSheet newValue: Bool)
    func update(showSettingSheet newValue: Bool)
    func update(showDeleteGoalAlert newValue: Bool)
    func update(selectedGoal newGoal: Goal)
    func update(sampleGoalData newGoalData: [Goal])
    //
    func getDisplayMonth(for date: Date, usersAppStartDate: Date) -> Month?
    func getDisplayMonth(showMonth: Bool, startDayIndex: Int, usersAppStartDate: Date ) -> Month?
}
