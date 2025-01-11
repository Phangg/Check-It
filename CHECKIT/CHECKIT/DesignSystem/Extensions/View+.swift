//
//  View+.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

extension View {
    func animatedStrikethrough(
        isActive: Bool,
        color: Color
    ) -> some View {
        modifier(AnimatedStrikethrough(isActive: isActive, color: color))
    }
}
