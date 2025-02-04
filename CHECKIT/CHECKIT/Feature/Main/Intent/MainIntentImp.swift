//
//  MainIntentImp.swift
//  CHECKIT
//
//  Created by phang on 2/3/25.
//

import Foundation

final class MainIntentImp {
    // Model
    private weak var model: MainModelAction?
        
    init(
        model: MainModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension MainIntentImp: MainIntent {
    func openGoalEditor(type: GoalEditorType) {
        switch type {
        case .add:
            model?.update(showAddGoalSheet: true)
        case .edit(let goal):
            model?.update(selectedGoal: goal)
            model?.update(showEditGoalSheet: true)
        }
    }
    
    func openSettingSheet() {
        model?.update(showSettingSheet: true)
    }
    
    func resetSelectedGoal() {
        model?.update(selectedGoal: nil)
    }
    
    func handleTapDeleteButton(for goal: Goal) {
        model?.update(selectedGoal: goal)
        model?.update(showDeleteGoalAlert: true)
    }
    
    //
    func update(showAddGoalSheet newValue: Bool) {
        model?.update(showAddGoalSheet: newValue)
    }
    
    func update(showEditGoalSheet newValue: Bool) {
        model?.update(showEditGoalSheet: newValue)
    }
    
    func update(showSettingSheet newValue: Bool) {
        model?.update(showSettingSheet: newValue)
    }
    
    func update(showDeleteGoalAlert newValue: Bool) {
        model?.update(showDeleteGoalAlert: newValue)
    }
    
    func update(selectedGoal newGoal: Goal) {
        model?.update(selectedGoal: newGoal)
    }
    
    func update(sampleGoalData newGoalData: [Goal]) {
        model?.update(sampleGoalData: newGoalData)
    }
    
    // 해당 날짜에 대한 여러 조건을 확인 후, Month 를 반환하는 메서드
    /// - date: 기준이 되는 날짜
    /// - usersAppStartDate: 사용자의 앱 시작 날짜
    func getDisplayMonth(
        for date: Date,
        usersAppStartDate: Date
    ) -> Month? {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        let startMonth = calendar.component(.month, from: usersAppStartDate)
        let startDay = calendar.component(.day, from: usersAppStartDate)
        // 앱 시작 월 특수 처리
        if currentMonth == startMonth {
            // 날짜가 사용자의 앱 시작일과 같은 경우 처리
            if calendar.isDate(date, inSameDayAs: usersAppStartDate) {
                return calendar.isDateInLastWeek(date)
                    ? calendar.getNextMonth(from: date) // 마지막 주라면 다음 달 반환
                    : Month.getMonth(for: currentMonth) // 그렇지 않다면 현재 달 반환
            }
            // 중복 표시 제거 처리 (앱 시작일이 4일 미만인 경우)
            if startDay < 4 && !calendar.isDateInLastWeek(date) {
                return nil
            }
        }
        // 일반적인 날짜 처리
        if calendar.isDateInFirstWeek(date) {
            return Month.getMonth(for: currentMonth) // 첫 번째 주라면 해당 월 반환
        }
        if calendar.isDateInLastWeek(date) {
            return calendar.getNextMonth(from: date) // 마지막 주라면 다음 달 반환
        }
        //
        return nil
    }

    // 주어진 조건을 확인하여, Month 를 반환하는 메서드
    /// - showMonth: 월을 표시할지 여부
    /// - startDayIndex: 사용자의 앱 시작 요일 (1: 월요일, 7: 일요일)
    /// - usersAppStartDate: 사용자의 앱 시작 날짜
    func getDisplayMonth(
        showMonth: Bool,
        startDayIndex: Int,
        usersAppStartDate: Date
    ) -> Month? {
        if showMonth {
            let calendar = Calendar.current
            // 앱 시작 요일이 수요일 이내이고 마지막 주에 포함되는 경우, 다음 달 반환
            if startDayIndex <= 3,
               calendar.isDateInLastWeek(usersAppStartDate) {
                return calendar.getNextMonth(from: usersAppStartDate)
            } else {
                return calendar.getMonth(from: usersAppStartDate) // 기본적으로 현재 월 반환
            }
        }
        return nil
    }
}
