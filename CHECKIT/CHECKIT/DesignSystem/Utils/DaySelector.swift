//
//  DaySelector.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct DaySelector: View {
    @State private var days: [Day] = [
        Day(dayString: "매일", isSelected: true),
        Day(dayString: "월", isSelected: false),
        Day(dayString: "화", isSelected: false),
        Day(dayString: "수", isSelected: false),
        Day(dayString: "목", isSelected: false),
        Day(dayString: "금", isSelected: false),
        Day(dayString: "토", isSelected: false),
        Day(dayString: "일", isSelected: false)
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
    
    private func updateDailySelection(for newDays: [Day]) {
        let weekDays = newDays.filter { $0.dayString != "매일" }
        if weekDays.allSatisfy({ $0.isSelected }) {
            days = days.map {
                if $0.dayString == "매일" {
                    Day(dayString: $0.dayString, isSelected: true)
                } else {
                    Day(dayString: $0.dayString, isSelected: false)
                }
            }
        }
    }
}

struct DayButton: View {
    @Binding private var day: Day
    @Binding private var days: [Day]
    
    init(
        day: Binding<Day>,
        days: Binding<[Day]>
    ) {
        self._day = day
        self._days = days
    }
    
    var body: some View {
        Button {
            handleSelection()
        } label: {
            Text(day.dayString)
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
        if day.dayString == "매일" {
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
