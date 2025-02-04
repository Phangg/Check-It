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
    @StateObject private var container: MVIContainer<MainIntent, MainModelState>
    private var intent: MainIntent { container.intent }
    private var state: MainModelState { container.model }
    
    init() {
        let model = MainModelImp()
        let intent = MainIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as MainIntent,
            model: model as MainModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
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
                        intent.openGoalEditor(type: .add)
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
            .sheet(
                isPresented: Binding(
                    get: { state.showAddGoalSheet },
                    set: { intent.update(showAddGoalSheet: $0) }
                )
            ) {
                GoalEditorView(.add)
                    .interactiveDismissDisabled()
            }
            // Setting Sheet
            .sheet(
                isPresented: Binding(
                    get: { state.showSettingSheet },
                    set: { intent.update(showSettingSheet: $0) }
                )
            ) {
                SettingView()
                    .interactiveDismissDisabled()
            }
            // Edit Goal Sheet
            .sheet(
                isPresented: .init(
                    get: { state.selectedGoal != nil && state.showEditGoalSheet },
                    set: { intent.update(showEditGoalSheet: $0) }
                ),
                onDismiss: {
                    intent.resetSelectedGoal()
                },
                content: {
                    GoalEditorView(.edit(goal: state.selectedGoal!))
                        .interactiveDismissDisabled()
                }
            )
            // Goal Delete Alert
            .alert(
                isPresented: .init(
                    get: { state.selectedGoal != nil && state.showDeleteGoalAlert },
                    set: { intent.update(showDeleteGoalAlert: $0) }
                )
            ) {
                Alert(
                    title: Text("'\(state.selectedGoal!.title)' 삭제"),
                    message: Text("달력에 있는 기록은 사라지지 않아요"),
                    primaryButton: .cancel(Text("취소")) {
                        intent.resetSelectedGoal()
                    },
                    secondaryButton: .destructive(Text("삭제")) {
                        // TODO: Goal 삭제
                        print("DELETE: \(state.selectedGoal?.title ?? "???")")
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
                intent.openSettingSheet()
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
                    rows: state.calendarRows,
                    alignment: .center,
                    spacing: ViewValues.Padding.small
                ) {
                    // 시작 위치 조정
                    let startDayIndex = Calendar.current.getDayIndexOfWeek(from: state.sampleCalendarData.first!.date)
                    if startDayIndex != 1 {
                        ForEach(0..<startDayIndex, id: \.self) { index in
                            GrowCell(
                                month: intent.getDisplayMonth(
                                    showMonth: index == 0,
                                    startDayIndex: startDayIndex,
                                    usersAppStartDate: state.sampleCalendarData.first!.date
                                ),
                                backgroundColor: .clear
                            )
                        }
                    }
                    //
                    ForEach(state.sampleCalendarData.indices, id: \.self) { index in
                        let day = state.sampleCalendarData[index]
                        if Calendar.current.getWeekday(from: day.date) == .monday {
                            // 월요일은 Month 표시 or 빈 공간 추가
                            GrowCell(
                                month: intent.getDisplayMonth(
                                    for: day.date,
                                    usersAppStartDate: state.sampleCalendarData.first!.date
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
                ForEach(
                    Binding(
                        get: { state.sampleGoalData },
                        set: { intent.update(sampleGoalData: $0) }
                    )
                ) { $goal in
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
                        intent.openGoalEditor(type: .edit(goal: goal))
                    } deleteAction: {
                        intent.handleTapDeleteButton(for: goal)
                    }
                    .padding(.horizontal, ViewValues.Padding.default)
                    .environmentObject(swipedCellManager)
                }
            }
        }
    }
}
