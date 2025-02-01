//
//  MainView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var swipedCellManager = SwipedCellManager()
    //
    @State private var sampleCalendarData: [DayData] = SampleData.days
    @State private var sampleGoalData: [Goal] = SampleData.goals
    @State private var showAddGoalSheet: Bool = false
    @State private var showSettingSheet: Bool = false
    //
    @State private var showEditGoalSheet: Bool = false
    @State private var showDeleteGoalAlert: Bool = false
    @State private var selectedGoal: Goal? = nil
    
    private let calendarRows = Array(
        repeating: GridItem(.flexible(), spacing: ViewValues.Padding.small),
        count: 7 + 1
    )
    
    var body: some View {
        NavigationStack { // TODO: 스택 위치 이동 예정
            VStack(alignment: .center, spacing: ViewValues.Padding.default) {
                // Calendar
                GoalCalendar()
                //
                Group {
                    // Divider
                    CustomDivider()
                    // Add Button
                    AddGoalButton {
                        showAddGoalSheet = true
                    }
                }
                .padding(.horizontal, ViewValues.Padding.default)
                // Goals
                GoalList()
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(edges: .bottom)
            // Toolbar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { MainViewToolbarContent() }
            // Add Goal Sheet
            .sheet(isPresented: $showAddGoalSheet) {
                GoalEditorView(.add)
                    .interactiveDismissDisabled()
            }
            // Setting Sheet
            .sheet(isPresented: $showSettingSheet) {
                SettingView()
                    .interactiveDismissDisabled()
            }
            // Edit Goal Sheet
            .sheet(
                isPresented: .init(
                    get: { selectedGoal != nil && showEditGoalSheet },
                    set: { showEditGoalSheet = $0 }
                ),
                onDismiss: {
                    selectedGoal = nil
                },
                content: {
                    GoalEditorView(.edit(goal: selectedGoal!))
                        .interactiveDismissDisabled()
                }
            )
            // Goal Delete Alert
            .alert(
                isPresented: .init(
                    get: { selectedGoal != nil && showDeleteGoalAlert },
                    set: { showDeleteGoalAlert = $0 }
                )
            ) {
                Alert(
                    title: Text("'\(selectedGoal!.title)' 삭제"),
                    message: Text("달력에 있는 기록은 사라지지 않아요"),
                    primaryButton: .cancel(Text("취소")) {
                        selectedGoal = nil
                    },
                    secondaryButton: .destructive(Text("삭제")) {
                        // TODO: Goal 삭제
                        print("DELETE: \(selectedGoal?.title ?? "???")")
                    }
                )
            }
            // Goal Cell 스와이프 열린 상태에서 탭 동작 시, cell 닫기 (tap 영역 버튼 동작 'O')
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        swipedCellManager.resetSwipedCell()
                    }
                    .whenCondition(swipedCellManager.currentlySwipedCellID != nil)
            )
            // Goal Cell 스와이프 열린 상태에서 스크롤 동작 시, cell 닫기 (기존 스크롤 뷰 동작 'O')
            .simultaneousGesture(
                DragGesture()
                    .onChanged { _ in
                        swipedCellManager.resetSwipedCell()
                    }
                    .whenCondition(swipedCellManager.currentlySwipedCellID != nil)
            )
        }
    }
    
    @ToolbarContentBuilder
    private func MainViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(DateFormat.dateToYearDotMonthDotDay(Date()))
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.semibold)
                .foregroundStyle(.budBlack)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showSettingSheet = true
            } label: {
                Image(systemName: "gearshape.fill")
            }
            .tint(.budBlack)
        }
    }
    
    @ViewBuilder
    private func GoalCalendar() -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: calendarRows,
                    alignment: .center,
                    spacing: ViewValues.Padding.small
                ) {
                    // 시작 위치 조정
                    let startDayIndex = Calendar.current.getDayIndexOfWeek(from: sampleCalendarData.first!.date)
                    if startDayIndex != 1 {
                        ForEach(0..<startDayIndex, id: \.self) { index in
                            GrowCell(
                                month: getDisplayMonth(
                                    showMonth: index == 0,
                                    startDayIndex: startDayIndex,
                                    usersAppStartDate: sampleCalendarData.first!.date
                                ),
                                backgroundColor: .clear
                            )
                        }
                    }
                    //
                    ForEach(sampleCalendarData.indices, id: \.self) { index in
                        let day = sampleCalendarData[index]
                        if Calendar.current.getWeekday(from: day.date) == .monday {
                            // 월요일은 Month 표시 or 빈 공간 추가
                            GrowCell(
                                month: getDisplayMonth(
                                    for: day.date,
                                    usersAppStartDate: sampleCalendarData.first!.date
                                ),
                                backgroundColor: .clear
                            )
                            GrowCell(day: day.dayOfMonth,
                                     backgroundColor: day.completionLevel.color)
                        } else {
                            // 기본
                            GrowCell(day: day.dayOfMonth,
                                     backgroundColor: day.completionLevel.color)
                        }
                    }
                }
                .padding(.horizontal, ViewValues.Padding.default)
                .id("GoalCalendar")
            }
            .scrollIndicators(.hidden)
            .frame(height: (30 * 8) + (ViewValues.Padding.small * 7))
            .onAppear {
                proxy.scrollTo("GoalCalendar", anchor: .trailing)
            }
        }
    }
    
    @ViewBuilder
    private func GoalList() -> some View {
        CustomHorizontalScrollView {
            LazyVStack(alignment: .center, spacing: ViewValues.Padding.default) {
                ForEach($sampleGoalData) { $goal in
                    GoalListCell(
                        isCompleted: $goal.isActive,
                        goalStreakCount: $goal.streakCount,
                        cellID: goal.id,
                        title: goal.title
                    ) {
                        // TODO: 메서드 수정 예정
                        if goal.isActive {
                            goal.streakCount += 1
                        } else {
                            goal.streakCount -= 1
                        }
                    } editAction: {
                        selectedGoal = goal
                        showEditGoalSheet = true
                    } deleteAction: {
                        selectedGoal = goal
                        showDeleteGoalAlert = true
                    }
                    .padding(.horizontal, ViewValues.Padding.default)
                    .environmentObject(swipedCellManager)
                }
            }
        }
    }
    
    // 해당 날짜에 대한 여러 조건을 확인 후, Month 를 반환하는 메서드
    private func getDisplayMonth(
        for date: Date,
        usersAppStartDate: Date
    ) -> Month? {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        let startMonth = calendar.component(.month, from: usersAppStartDate)
        let startDay = calendar.component(.day, from: usersAppStartDate)
        // 앱 시작 월 특수 처리
        if currentMonth == startMonth {
            // 앱 시작일 처리
            if calendar.isDate(date, inSameDayAs: usersAppStartDate) {
                return calendar.isDateInLastWeek(date)
                    ? calendar.getNextMonth(from: date)
                    : Month.getMonth(for: currentMonth)
            }
            // 중복 표시 제거 처리
            if startDay < 4 && !calendar.isDateInLastWeek(date) {
                return nil
            }
        }
        // 일반적인 날짜 처리
        if calendar.isDateInFirstWeek(date) {
            return Month.getMonth(for: currentMonth)
        }
        if calendar.isDateInLastWeek(date) {
            return calendar.getNextMonth(from: date)
        }
        //
        return nil
    }
    
    private func getDisplayMonth(
        showMonth: Bool,
        startDayIndex: Int,
        usersAppStartDate: Date
    ) -> Month? {
        if showMonth {
            let calendar = Calendar.current
            if startDayIndex <= 3,
               calendar.isDateInLastWeek(usersAppStartDate) {
                return calendar.getNextMonth(from: usersAppStartDate)
            } else {
                return calendar.getMonth(from: usersAppStartDate)
            }
        }
        return nil
    }
}
