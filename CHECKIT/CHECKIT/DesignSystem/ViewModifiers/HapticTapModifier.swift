//
//  HapticTapModifier.swift
//  CHECKIT
//
//  Created by phang on 1/23/25.
//

import SwiftUI

struct HapticTapModifier: ViewModifier {
    private let hapticManager = HapticManager.shared
    private let type: HapticType
    
    init(
        type: HapticType
    ) {
        self.type = type
    }
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture().onEnded { _ in
                    switch type {
                    case .impact(let feedbackStyle):
                        hapticManager.triggerImpact(style: feedbackStyle)
                    case .notification(let feedbackType):
                        hapticManager.triggerNotification(type: feedbackType)
                    }
                }
            )
    }
}
