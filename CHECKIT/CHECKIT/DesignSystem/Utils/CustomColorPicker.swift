//
//  CustomColorPicker.swift
//  CHECKIT
//
//  Created by phang on 1/24/25.
//

import SwiftUI

struct CustomColorPicker: View {
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @State private var brightness: CGFloat
    @State private var temporarySelectedColor: Color
    @Binding private var showColorPicker: Bool
    
    private let colors: [Color] = [
        .accent, .red, .orange, .yellow,
        .green, .mint, .cyan, .brown,
        .indigo, .purple, .pink
    ]
    private let adaptiveColumn = Array(repeating: GridItem(.adaptive(minimum: 40)), count: 4)
    
    init(
        appMainColor: AppMainColor,
        showColorPicker: Binding<Bool>
    ) {
        self._brightness = State(initialValue: appMainColor.brightness)
        self._temporarySelectedColor = State(initialValue: appMainColor.baseColor)
        self._showColorPicker = showColorPicker
    }
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
            // Header
            CustomColorHeader()
            // Picker
            LazyVGrid(columns: adaptiveColumn, spacing: ViewValues.Padding.default) {
                //
                ForEach(colors, id: \.self) { color in
                    CellButton(
                        item: color.adjust(brightness: color == temporarySelectedColor ? brightness : 0),
                        isSelected: color == temporarySelectedColor
                    ) {
                        temporarySelectedColor = color
                    }
                }
                // 초기화 버튼
                Button {
                    brightness = 0
                    temporarySelectedColor = .accent
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.budBlack)
                }
            }
            //
            ColorSlider(
                value: $brightness,
                selectedColor: temporarySelectedColor,
                range: -0.5...0.5
            )
            .padding(.vertical, ViewValues.Padding.medium)
            .padding(.horizontal, ViewValues.Padding.default)
        }
        .padding(ViewValues.Padding.default)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background {
            ZStack {
                Color(uiColor: UIColor.systemBackground)
                LinearGradient(
                    colors: [
                        temporarySelectedColor.adjust(brightness: brightness).opacity(0),
                        temporarySelectedColor.adjust(brightness: brightness).opacity(0.025),
                        temporarySelectedColor.adjust(brightness: brightness).opacity(0.05),
                        temporarySelectedColor.adjust(brightness: brightness).opacity(0.075),
                        temporarySelectedColor.adjust(brightness: brightness).opacity(0.1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .clipShape(.rect(cornerRadius: ViewValues.Radius.default))
        }
        .padding(.horizontal, ViewValues.Padding.default)
        .presentationDetents([.height(ViewValues.Size.pickerViewHeight)])
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    fileprivate func CustomColorHeader() -> some View {
        HStack(alignment: .center) {
            //
            Text("앱 메인 색상 설정")
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.medium)
                .foregroundStyle(.budBlack)
            //
            Spacer(minLength: ViewValues.Padding.large)
            //
            Button {
                appMainColorManager.updateAppMainColor(
                    to: .init(brightness: brightness, baseColor: temporarySelectedColor)
                )
                showColorPicker = false
            } label: {
                Text("완료")
                    .font(.system(size: 18)) // TODO: font 수정 예정
                    .fontWeight(.medium)
                    .foregroundStyle(.budBlack)
            }
        }
    }
}

// MARK: - CustomColorPicker 에서만 사용되는 버튼
fileprivate struct CellButton: View {
    private let item: Color
    private let isSelected: Bool
    private let action: () -> Void
    
    init(
        item: Color,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.item = item
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        GrowCell(backgroundColor: item)
            .overlay(alignment: .center) {
                Image(systemName: "checkmark")
                    .fontWeight(.semibold)
                    .foregroundStyle(isSelected ? .budWhite : .clear)
            }
            .onTapGesture {
                action()
            }
    }
}

// MARK: - CustomColorPicker 에서만 사용되는 슬라이더
fileprivate struct ColorSlider: View {
    @State private var lastOffset: CGFloat = 0
    @Binding private var value: CGFloat
    private let selectedColor: Color
    private let range: ClosedRange<CGFloat>
    private let leadingOffset: CGFloat = -2
    private let trailingOffset: CGFloat = -2
    private var trackGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                selectedColor.adjust(brightness: range.upperBound),
                selectedColor,
                selectedColor.adjust(brightness: range.lowerBound)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    init(
        value: Binding<CGFloat>,
        selectedColor: Color,
        range: ClosedRange<CGFloat>
    ) {
        self._value = value
        self.selectedColor = selectedColor
        self.range = range
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                //
                RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                    .frame(height: ViewValues.Size.colorSliderHeight)
                    .foregroundStyle(trackGradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                            .stroke(trackGradient, lineWidth: ViewValues.Size.midLineWidth)
                    }
                //
                HStack {
                    Circle()
                        .fill(selectedColor.adjust(brightness: value))
                        .overlay {
                            Circle()
                                .strokeBorder(.budWhite, lineWidth: ViewValues.Size.midLineWidth)
                        }
                        .shadow(radius: 8, y: 5)
                        .frame(width: ViewValues.Size.colorSliderKnobSize,
                               height: ViewValues.Size.colorSliderKnobSize)
                        .offset(x: knobOffset(in: geo))
                        .gesture(dragGesture(in: geo))
                    //
                    Spacer()
                }
            }
        }
    }
    
    private func knobOffset(in geometry: GeometryProxy) -> CGFloat {
        let outputRange = min(
            leadingOffset,
            geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset
        )...max(
            leadingOffset,
            geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset
        )
        
        return (geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset)
        - value.map(from: range, to: outputRange)
    }
    
    private func dragGesture(in geometry: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { dragValue in
                if abs(dragValue.translation.width) < 0.1 {
                    lastOffset = (geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset)
                    - value.map(from: range, to: leadingOffset...(geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset))
                }
                let sliderPos = max(
                    leadingOffset,
                    min(lastOffset + dragValue.translation.width,
                        geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset)
                )
                let sliderVal = (geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset - sliderPos)
                    .map(from: leadingOffset...(geometry.size.width - ViewValues.Size.colorSliderKnobSize - trailingOffset),
                         to: range)
                value = sliderVal
            }
    }
}
