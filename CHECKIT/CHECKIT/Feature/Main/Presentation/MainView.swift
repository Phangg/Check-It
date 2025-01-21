//
//  MainView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct MainView: View {
    @State private var sampleCalendarData: [DayData] = SampleData.days
    @State private var sampleGoalData: [Goal] = SampleData.goals
    @State private var showAddGoalSheet: Bool = false
    @State private var showSettingSheet: Bool = false
    
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
                    CustomDivider(color: .cellLevel1, type: .horizontal())
                    // Add Button
                    AddGoalButton {
                        // TODO: AddGoal 시트 열기
                        showAddGoalSheet = true
                    }
                }
                .padding(.horizontal, ViewValues.Padding.default)
                // Goals
                GoalList()
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { MainViewToolbarContent() }
            // AddGoal Sheet
            .sheet(isPresented: $showAddGoalSheet) {
                AddGoalView()
                    .interactiveDismissDisabled()
            }
            // Setting Sheet
            .sheet(isPresented: $showSettingSheet) {
                SettingView()
                    .interactiveDismissDisabled()
            }
        }
    }
    
    @ToolbarContentBuilder
    fileprivate func MainViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(DateFormat.dateToYearDotMonthDotDay(Date())) // TODO: 날짜 수정 예정
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.semibold)
                .foregroundStyle(.budBlack)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: 설정 시트 열기
                showSettingSheet = true
            } label: {
                Image(systemName: "gearshape.fill")
            }
            .tint(.budBlack)
        }
    }
    
    @ViewBuilder
    fileprivate func GoalCalendar() -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: calendarRows,
                    alignment: .center,
                    spacing: ViewValues.Padding.small
                ) {
                    // 시작 위치 조정
                    let startDayIndex = Date.getDayIndexOfWeek(for: sampleCalendarData.first!.date)
                    if startDayIndex != 1 {
                        ForEach(0..<startDayIndex, id: \.self) { index in
                            GrowCell(
                                month: index == 0 ? Date.getMonth(for: sampleCalendarData.first!.date) : nil,
                                backgroundColor: .clear
                            )
                        }
                    }
                    //
                    ForEach(sampleCalendarData.indices, id: \.self) { index in
                        let day = sampleCalendarData[index]
                        if Date.getWeekday(for: day.date) == .monday {
                            // 월요일은 Month 표시 or 빈 공간 추가
                            GrowCell(
                                month: Date.checkFirstWeekMonth(
                                    for: day.date,
                                    isStartDay: startDayIndex == 1 && day == sampleCalendarData.first
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
    fileprivate func GoalList() -> some View {
        CustomHorizontalScrollView {
            LazyVStack(alignment: .center, spacing: ViewValues.Padding.default) {
                ForEach($sampleGoalData.indices, id: \.self) { index in
                    GoalListCell(
                        isCompleted: $sampleGoalData[index].isActive,
                        goalStreakCount: $sampleGoalData[index].streakCount,
                        title: sampleGoalData[index].title
                    ) {
                        // TODO: 메서드 수정 예정
                        if sampleGoalData[index].isActive {
                            sampleGoalData[index].streakCount += 1
                        } else {
                            sampleGoalData[index].streakCount -= 1
                        }
                    }
                    .padding(.horizontal, ViewValues.Padding.default)
                }
            }
        }
    }
}
