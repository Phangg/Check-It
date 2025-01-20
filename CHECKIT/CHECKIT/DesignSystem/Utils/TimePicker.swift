//
//  TimePicker.swift
//  CHECKIT
//
//  Created by phang on 1/20/25.
//

import SwiftUI

struct TimePicker: View {
    @State private var temporaryTime: Date
    @Binding private var selectedTime: Date
    @Binding private var showTimePicker: Bool
    
    init(
        selectedTime: Binding<Date>,
        showTimePicker: Binding<Bool>
    ) {
        self._temporaryTime = State(initialValue: selectedTime.wrappedValue)
        self._selectedTime = selectedTime
        self._showTimePicker = showTimePicker
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.medium) {
            // Header
            TimePickerHeader()
            // Description
            Text("알림을 받을 시간을 설정해주세요 \n목표 달성을 돕는 알림을 보내드릴게요!")
                .font(.system(size: 16))  // TODO: font 수정 예정
                .fontWeight(.regular)
                .lineLimit(2)
                .foregroundStyle(.midGray)
                .backgroundStyle(.red)
            //
            Spacer(minLength: ViewValues.Padding.zero)
            // Picker
            TimePickerContent()
        }
        .padding(ViewValues.Padding.default)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                Rectangle()
                    .fill(.budBlack.opacity(ViewValues.Opacity.light))
            }
            .clipShape(.rect(cornerRadius: ViewValues.Radius.default))
        }
        .padding(.horizontal, ViewValues.Padding.default)
        .presentationDetents([.height(ViewValues.Size.timePickerViewHeight)])
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    fileprivate func TimePickerHeader() -> some View {
        HStack(alignment: .center) {
            //
            Text("알람 설정")
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.medium)
                .foregroundStyle(.budBlack)
            //
            Spacer(minLength: ViewValues.Padding.large)
            //
            Button {
                selectedTime = temporaryTime
                showTimePicker = false
            } label: {
                Text("완료")
                    .font(.system(size: 18)) // TODO: font 수정 예정
                    .fontWeight(.medium)
                    .foregroundStyle(.budBlack)
            }
        }
    }
    
    @ViewBuilder
    fileprivate func TimePickerContent() -> some View {
        DatePicker(
            "알림 시간 설정",
            selection: $temporaryTime,
            displayedComponents: .hourAndMinute
        )
        .datePickerStyle(.wheel)
        .labelsHidden()
        .scaleEffect(ViewValues.Scale.datePickerScale)
        .frame(height: ViewValues.Size.timePickerHeight)
    }
}
