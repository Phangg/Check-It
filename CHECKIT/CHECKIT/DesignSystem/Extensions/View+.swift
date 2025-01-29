//
//  View+.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

extension View {
    //
    func animatedStrikethrough(
        isActive: Bool,
        color: Color,
        height: CGFloat = 1,
        duration: Double = ViewValues.Duration.regular
    ) -> some View {
        modifier(
            AnimatedStrikethrough(
                isActive: isActive,
                color: color,
                height: height,
                duration: duration
            )
        )
    }
    
    //
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //
    func hapticOnTap(type: HapticType, isActive: Bool = true) -> some View {
        Group {
            if isActive {
                self.modifier(HapticTapModifier(type: type))
            } else {
                self
            }
        }
    }
}
