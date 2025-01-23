//
//  HapticManager.swift
//  CHECKIT
//
//  Created by phang on 1/23/25.
//

import SwiftUI

final class HapticManager {
    static let shared = HapticManager()
    
    private init() { }
    
    func triggerImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func triggerNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
