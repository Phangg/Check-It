//
//  GoalEditorView.swift
//  CHECKIT
//
//  Created by phang on 1/30/25.
//

import SwiftUI

struct GoalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    //
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @StateObject private var container: MVIContainer<GoalEditorIntent, GoalEditorModelState>
    private var intent: GoalEditorIntent { container.intent }
    private var state: GoalEditorModelState { container.model }
    
    init(
        _ type: GoalEditorType
    ) {
        let model = GoalEditorModelImp(
            type: type
        )
        let intent = GoalEditorIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as GoalEditorIntent,
            model: model as GoalEditorModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
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
                    NotificationSection()
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
            .sheet(
                isPresented: Binding(
                    get: { state.showTimePicker },
                    set: { intent.update(showTimePicker: $0) }
                )
            ) {
                TimePicker(
                    selectedTime: Binding(
                        get: { state.selectedTime },
                        set: { intent.update(selectedTime: $0) }
                    ),
                    showTimePicker: Binding(
                        get: { state.showTimePicker },
                        set: { intent.update(showTimePicker: $0) }
                    )
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
            TextBox(
                text: Binding(
                    get: { state.goalTitleText },
                    set: { intent.update(goalTitleText: $0) }
                )
            )
            .onChange(of: state.goalTitleText) { _, newText in
                intent.validateSaveButton(
                    goalTitleText: newText,
                    selectedDays: state.selectedDays
                )
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
            DaySelector(
                selectedDays: Binding(
                    get: { state.selectedDays },
                    set: { intent.update(selectedDays: $0) }
                )
            )
            .onChange(of: state.selectedDays) { _, newSelectedDays in
                intent.validateSaveButton(
                    goalTitleText: state.goalTitleText,
                    selectedDays: newSelectedDays
                )
            }
        }
    }
    
    @ViewBuilder
    private func SaveButton() -> some View {
        CustomDefaultButton(
            isButtonActive: Binding(
                get: { state.isSaveButtonActive },
                set: { intent.update(isSaveButtonActive: $0) }
            ),
            style: .filled,
            text: "저장하기"
        ) {
            // TODO: 목표 저장 or 수정 & dismiss
            dismiss()
        }
        .padding(.vertical, ViewValues.Padding.default)
        .padding(.horizontal, ViewValues.Padding.medium)
    }
    
    @ViewBuilder
    private func NotificationSection() -> some View {
        GoalSection(
            title: "알림 설정",
            isRequired: false,
            description: "기기 설정 및 앱 설정에서 알림 허용이 되어있어야 해요"
        ) {
            // TimePickerButton & Toggle
            HStack(alignment: .center) {
                // TimePickerButton
                if state.isGoalNotificationEnabled {
                    Button {
                        intent.openTimePicker()
                    } label: {
                        Text(DateFormat.timeFormatter.string(from: state.selectedTime))
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
                Toggle(
                    "NotificationToggle",
                    isOn: Binding(get: { state.isGoalNotificationEnabled },
                                  set: { intent.update(isGoalNotificationEnabled: $0) }
                                 )
                )
                .labelsHidden()
                .tint(appMainColorManager.appMainColor.mainColor)
            }
            .frame(height: ViewValues.Size.goalNotificationStackHeight)
        }
    }
}
