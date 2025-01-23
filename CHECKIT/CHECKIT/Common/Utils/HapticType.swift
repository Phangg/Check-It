//
//  HapticType.swift
//  CHECKIT
//
//  Created by phang on 1/23/25.
//

import UIKit

enum HapticType {
    case impact(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(feedbackType: UINotificationFeedbackGenerator.FeedbackType)
}
