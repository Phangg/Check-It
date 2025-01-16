//
//  PressButtonStyle.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import SwiftUI

struct PressButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? ViewValues.Scale.pressed : ViewValues.Scale.default)
            .onChange(of: configuration.isPressed) { _, newValue in
                withAnimation(.easeInOut(duration: ViewValues.Duration.regular)) {
                    isPressed = newValue
                }
            }
    }
}
