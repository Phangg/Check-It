//
//  DaySelector.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct DaySelector: View {
    @Binding private var selectedDays: [DayInSelector]
    
    init(
        selectedDays: Binding<[DayInSelector]>
    ) {
        self._selectedDays = selectedDays
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
                //
                ForEach($selectedDays, id: \.self) { $day in
                    DayButton(day: $day, days: $selectedDays)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct DayButton: View {
    @Binding private var day: DayInSelector
    @Binding private var days: [DayInSelector]
    
    init(
        day: Binding<DayInSelector>,
        days: Binding<[DayInSelector]>
    ) {
        self._day = day
        self._days = days
    }
    
    var body: some View {
        Button {
            handleSelection()
        } label: {
            Text(day.day.rawValue)
                .font(.system(size: 13)) // TODO: 폰트 설정 필요
                .foregroundStyle(day.isSelected ? .budWhite : .budBlack)
                .padding(.horizontal, ViewValues.Padding.medium)
                .padding(.vertical, ViewValues.Padding.mid)
                .background(
                    RoundedRectangle(cornerRadius: ViewValues.Radius.medium)
                        .fill(day.isSelected ? .blue : .softGray) // TODO: color 수정 필요
                        .strokeBorder(day.isSelected ? .clear : .midGray,
                                      lineWidth: ViewValues.Size.lineWidth)
                )
        }
        .buttonStyle(.plain)
    }
    
    private func handleSelection() {
        if day.day == .allDay {
            let shouldSelect = !day.isSelected
            days.indices.forEach { index in
                days[index].isSelected = shouldSelect
            }
        } else {
            day.isSelected.toggle()
            let allSelected = days.dropFirst().allSatisfy { $0.isSelected }
            days[0].isSelected = allSelected
        }
    }
}

#Preview {
    DaySelector(
        selectedDays: .constant(
            [.init(day: .allDay, isSelected: true),
             .init(day: .monday, isSelected: true),
             .init(day: .tuesday, isSelected: true),
             .init(day: .wednesday, isSelected: true),
             .init(day: .thursday, isSelected: true),
             .init(day: .friday, isSelected: true),
             .init(day: .saturday, isSelected: true),
             .init(day: .sunday, isSelected: true)]
        )
    )
}
