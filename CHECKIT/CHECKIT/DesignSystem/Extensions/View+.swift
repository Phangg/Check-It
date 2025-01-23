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
        color: Color
    ) -> some View {
        modifier(AnimatedStrikethrough(isActive: isActive, color: color))
    }
    
    //
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //
    func hapticOnTap(type: HapticType) -> some View {
        modifier(HapticTapModifier(type: type))
    }
}
