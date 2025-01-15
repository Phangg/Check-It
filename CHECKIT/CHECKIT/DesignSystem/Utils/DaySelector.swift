//
//  DaySelector.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct DaySelector: View {
    @State private var days: [DayInSelector] = [
        .init(day: .allDay, isSelected: true),
        .init(day: .monday, isSelected: false),
        .init(day: .tuesday, isSelected: false),
        .init(day: .wednesday, isSelected: false),
        .init(day: .thursday, isSelected: false),
        .init(day: .friday, isSelected: false),
        .init(day: .saturday, isSelected: false),
        .init(day: .sunday, isSelected: false)
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
                //
                ForEach($days, id: \.self) { $day in
                    DayButton(day: $day, days: $days)
                }
            }
            .padding(.leading, ViewValues.Padding.default)
            .onChange(of: days) { _, newDays in
                updateDailySelection(for: newDays)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func updateDailySelection(for newDays: [DayInSelector]) {
        let weekDays = newDays.filter { $0.day != .allDay }
        if weekDays.allSatisfy({ $0.isSelected }) {
            days = days.map {
                if $0.day == .allDay {
                    DayInSelector(day: $0.day, isSelected: true)
                } else {
                    DayInSelector(day: $0.day, isSelected: false)
                }
            }
        }
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
                days[index].isSelected = shouldSelect && index == 0
            }
        } else {
            day.isSelected.toggle()
            days[0].isSelected = false
        }
    }
}

#Preview {
    DaySelector()
}
