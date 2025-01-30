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
    private let isActive: Bool

    init(
        type: HapticType,
        isActive: Bool
    ) {
        self.type = type
        self.isActive = isActive
    }
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        if isActive {
                            switch type {
                            case .impact(let feedbackStyle):
                                hapticManager.triggerImpact(style: feedbackStyle)
                            case .notification(let feedbackType):
                                hapticManager.triggerNotification(type: feedbackType)
                            }
                        }
                    }
            )
    }
}
