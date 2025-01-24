//
//  AddGoalView.swift
//  CHECKIT
//
//  Created by phang on 1/19/25.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var goalTitleText: String = ""
    @State private var selectedDays: [DayInSelector] = [
        .init(day: .allDay, isSelected: true),
        .init(day: .monday, isSelected: true),
        .init(day: .tuesday, isSelected: true),
        .init(day: .wednesday, isSelected: true),
        .init(day: .thursday, isSelected: true),
        .init(day: .friday, isSelected: true),
        .init(day: .saturday, isSelected: true),
        .init(day: .sunday, isSelected: true)
    ]
    @State private var isSaveButtonActive: Bool = false
    @State private var isGoalNotificationEnabled: Bool = true
    @State private var selectedTime: Date = Calendar.current.date(from: DateComponents(hour: 18, minute: 0)) ?? Date()
    @State private var showTimePicker: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                //
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                //
                VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
                    // Goal
                    AddGoalSectionView(
                        title: "데일리 목표",
                        isRequired: true,
                        description: nil
                    ) {
                        TextBox(text: $goalTitleText)
                            .onChange(of: goalTitleText) { _, _ in
                                validateSaveButton()
                            }
                    }
                    //
                    CustomDivider(
                        color: .cellLevel1,
                        type: .horizontal()
                    )
                    // WeekDay
                    AddGoalSectionView(
                        title: "요일 설정",
                        isRequired: true,
                        description: "중복 선택 가능"
                    ) {
                        DaySelector(selectedDays: $selectedDays)
                            .onChange(of: selectedDays) { _, _ in
                                validateSaveButton()
                            }
                    }
                    //
                    CustomDivider(
                        color: .cellLevel1,
                        type: .horizontal()
                    )
                    // Notification
                    AddGoalSectionView(
                        title: "알림 설정",
                        isRequired: false,
                        description: "기기 설정 및 앱 설정에서 알림 허용이 되어있어야 해요-"
                    ) {
                        NotificationHStack()
                    }
                    //
                    Spacer(minLength: ViewValues.Padding.default)
                    // Save Button
                    CustomDefaultButton(
                        isButtonActive: $isSaveButtonActive,
                        style: .filled,
                        text: "저장하기"
                    ) {
                        // TODO: 목표 저장 & dismiss
                        dismiss()
                    }
                    .padding(.vertical, ViewValues.Padding.default)
                    .padding(.horizontal, ViewValues.Padding.medium)
                }
                .ignoresSafeArea(.keyboard)
                .frame(maxHeight: .infinity)
                .padding(.horizontal, ViewValues.Padding.default)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { AddGoalViewToolbarContent() }
            }
            .sheet(isPresented: $showTimePicker) {
                TimePicker(
                    selectedTime: $selectedTime,
                    showTimePicker: $showTimePicker
                )
            }
        }
    }
        
    @ToolbarContentBuilder
    fileprivate func AddGoalViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .tint(.budBlack)
        }
    }
    
    @ViewBuilder
    fileprivate func NotificationHStack() -> some View {
        // TimePickerButton & Toggle
        HStack(alignment: .center) {
            // TimePickerButton
            if isGoalNotificationEnabled {
                Button {
                    // TODO: TimePicker 열기
                    showTimePicker = true
                } label: {
                    Text(DateFormat.timeFormatter.string(from: selectedTime))
                        .font(.system(size: 16)) // TODO: font 수정 예정
                        .fontWeight(.regular)
                        .foregroundStyle(.budBlack)
                        .padding(ViewValues.Padding.medium)
                        .background {
                            RoundedRectangle(cornerRadius: ViewValues.Radius.small)
                                .fill(.neutralGray)
                        }
                }
                .buttonStyle(.plain)
            }
            //
            Spacer(minLength: ViewValues.Padding.large)
            // Toggle
            Toggle("NotificationToggle", isOn: $isGoalNotificationEnabled)
                .labelsHidden()
                .tint(.accent) // TODO: color 수정 예정
        }
        .frame(height: ViewValues.Size.goalNotificationStackHeight)
    }
    
    private func validateSaveButton() {
        isSaveButtonActive = !goalTitleText.isEmpty &&
            selectedDays.contains(where: { $0.isSelected })
    }
}
