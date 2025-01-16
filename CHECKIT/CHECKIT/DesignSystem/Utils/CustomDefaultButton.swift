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
    
    private let style: CustomDefaultButtonStyle
    private let text: String
    private let action: () -> Void
    
    init(
        style: CustomDefaultButtonStyle,
        text: String,
        action: @escaping () -> Void
        
    ) {
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
                    .fill(style.backgroundColor)
                    .strokeBorder(.midGray, lineWidth: ViewValues.Size.lineWidth)
                    .overlay {
                        Capsule()
                            .fill(isPressed ? .budBlack.opacity(ViewValues.Opacity.light) : .clear)
                    }
                    .frame(height: ViewValues.Size.defaultButtonHeight)
                // Label
                Text(text)
                    .foregroundStyle(style.foregroundColor) // TODO: font 설정 필요
            }
        }
        .buttonStyle(PressButtonStyle(isPressed: $isPressed))
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
