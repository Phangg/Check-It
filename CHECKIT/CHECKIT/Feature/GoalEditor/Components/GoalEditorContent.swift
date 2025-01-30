//
//  GoalEditorContent.swift
//  CHECKIT
//
//  Created by phang on 1/30/25.
//

import SwiftUI

struct GoalEditorContent: View {
    @Environment(\.dismiss) private var dismiss
    //
    @State private var goalTitleText: String
    @State private var selectedDays: [DayInSelector]
    @State private var isSaveButtonActive: Bool
    @State private var isGoalNotificationEnabled: Bool
    @State private var selectedTime: Date
    @State private var showTimePicker: Bool

    init(
        goalTitleText: String = "",
        selectedDays: [DayInSelector] = DayInSelector.defaultDays,
        isGoalNotificationEnabled: Bool = true,
        selectedTime: Date = Calendar.current.date(from: DateComponents(hour: 18, minute: 0)) ?? Date(),
        showTimePicker: Bool = false
    ) {
        self.goalTitleText = goalTitleText
        self.selectedDays = selectedDays
        self.isSaveButtonActive = !goalTitleText.isEmpty && selectedDays.contains(where: { $0.isSelected })
        self.isGoalNotificationEnabled = isGoalNotificationEnabled
        self.selectedTime = selectedTime
        self.showTimePicker = showTimePicker
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // BG
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                //
                VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
                    // Goal
                    TitleSection()
                    //
                    CustomDivider()
                    // WeekDay
                    DaysSection()
                    //
                    CustomDivider()
                    // Notification
                    NotificationSectionView(
                        isGoalNotificationEnabled: $isGoalNotificationEnabled,
                        selectedTime: $selectedTime,
                        showTimePicker: $showTimePicker
                    )
                    //
                    Spacer(minLength: ViewValues.Padding.default)
                    // Save Button
                    SaveButton()
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
    private func AddGoalViewToolbarContent() -> some ToolbarContent {
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
    private func TitleSection() -> some View {
        GoalSection(
            title: "데일리 목표",
            isRequired: true,
            description: nil
        ) {
            TextBox(text: $goalTitleText)
                .onChange(of: goalTitleText) { _, _ in
                    validateSaveButton()
                }
        }
    }
    
    @ViewBuilder
    private func DaysSection() -> some View {
        GoalSection(
            title: "요일 설정",
            isRequired: true,
            description: "중복 선택 가능"
        ) {
            DaySelector(selectedDays: $selectedDays)
                .onChange(of: selectedDays) { _, _ in
                    validateSaveButton()
                }
        }
    }
    
    @ViewBuilder
    private func SaveButton() -> some View {
        CustomDefaultButton(
            isButtonActive: $isSaveButtonActive,
            style: .filled,
            text: "저장하기"
        ) {
            // TODO: 목표 저장 or 수정 & dismiss
            dismiss()
        }
        .padding(.vertical, ViewValues.Padding.default)
        .padding(.horizontal, ViewValues.Padding.medium)
    }
    
    private func validateSaveButton() {
        isSaveButtonActive = !goalTitleText.isEmpty &&
            selectedDays.contains(where: { $0.isSelected })
    }
}

//
fileprivate struct NotificationSectionView: View {
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    @Binding var isGoalNotificationEnabled: Bool
    @Binding var selectedTime: Date
    @Binding var showTimePicker: Bool
    
    var body: some View {
        GoalSection(
            title: "알림 설정",
            isRequired: false,
            description: "기기 설정 및 앱 설정에서 알림 허용이 되어있어야 해요"
        ) {
            NotificationHStack()
        }
    }
    
    @ViewBuilder
    private func NotificationHStack() -> some View {
        // TimePickerButton & Toggle
        HStack(alignment: .center) {
            // TimePickerButton
            if isGoalNotificationEnabled {
                Button {
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
                .tint(appMainColorManager.appMainColor.mainColor)
        }
        .frame(height: ViewValues.Size.goalNotificationStackHeight)
    }
}
