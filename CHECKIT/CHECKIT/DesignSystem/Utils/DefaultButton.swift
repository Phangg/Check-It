//
//  DefaultButton.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct CustomDefaultButton: View {
    private let style: CustomDefaultButtonStyle
    private let text: String
    private let action: () -> Void
    
    // For managing button animation
    @State private var isPressed = false
    
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
        ZStack(alignment: .center) {
            // BG
            Capsule()
                .fill(style.backgroundColor)
                .strokeBorder(.gray, lineWidth: ViewValues.Size.defaultLineWidth) // TODO: color 수정 필요
                .overlay {
                    Capsule()
                        .fill(isPressed ?  .black.opacity(ViewValues.Opacity.light) : .clear) // TODO: color 수정 필요
                }
                .frame(height: ViewValues.Size.defaultButtonHeight)
                .scaleEffect(isPressed ? ViewValues.Scale.pressedButton : ViewValues.Scale.default)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            withAnimation(.easeInOut(duration: ViewValues.Duration.regular)) {
                                isPressed = true
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.easeInOut(duration: ViewValues.Duration.regular)) {
                                isPressed = false
                                action()
                            }
                        }
                )
            // Label
            Text(text)
                .foregroundStyle(style.foregroundColor)
                // TODO: - 버튼 폰트 설정 필요
                .scaleEffect(isPressed ? ViewValues.Scale.pressedButton : ViewValues.Scale.default)
        }
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
