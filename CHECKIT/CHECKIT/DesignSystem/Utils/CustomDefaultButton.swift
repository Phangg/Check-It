//
//  CustomDefaultButton.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct CustomDefaultButton: View {
    // For managing button animation
    @State private var isPressed = false
    @Binding private var isButtonActive: Bool
    
    private let style: CustomDefaultButtonStyle
    private let text: String
    private let action: () -> Void
    
    init(
        isButtonActive: Binding<Bool>? = nil,
        style: CustomDefaultButtonStyle,
        text: String,
        action: @escaping () -> Void
        
    ) {
        self._isButtonActive = if let isButtonActive { isButtonActive } else { .constant(true) }
        self.style = style
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack(alignment: .center) {
                // BG
                Capsule()
                    .fill(isButtonActive ? style.backgroundColor : .midGray)
                    .strokeBorder(
                        style == .bordered ? .midGray : .clear,
                        lineWidth: ViewValues.Size.lineWidth
                    )
                    .overlay {
                        Capsule()
                            .fill(isPressed ? .black.opacity(ViewValues.Opacity.light) : .clear) // 항상 어두운 그림자 사용
                    }
                    .frame(height: ViewValues.Size.defaultButtonHeight)
                // Label
                Text(text)
                    .font(.system(size: 16)) // TODO: font 설정 필요
                    .fontWeight(.medium)
                    .foregroundStyle(style.foregroundColor)
            }
        }
        .buttonStyle(PressButtonStyle(isPressed: $isPressed))
        .disabled(!isButtonActive)
    }
}

#Preview {
    // Buttons
    VStack(spacing: ViewValues.Padding.default) {
        // Filled
        CustomDefaultButton(
            style: .filled,
            text: "Filled Button"
        ) {
            print("Tap FilledButton")
        }
        // Bordered
        CustomDefaultButton(
            style: .bordered,
            text: "Bordered Button"
        ) {
            print("Tap BorderedButton")
        }
    }
    .padding(ViewValues.Padding.default)
}
