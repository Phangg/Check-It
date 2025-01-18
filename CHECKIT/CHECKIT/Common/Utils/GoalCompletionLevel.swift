//
//  GoalCompletionLevel.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import SwiftUI

enum CompletionLevel: String, Hashable, CaseIterable {
    case level1
    case level2
    case level3
    case level4
    case level5
    
    var color: Color {
        switch self {
        case .level1:
            .cellLevel1
        case .level2:
            .blue.opacity(ViewValues.Opacity.level2) // TODO: color 수정 예정
        case .level3:
            .blue.opacity(ViewValues.Opacity.level3)
        case .level4:
            .blue.opacity(ViewValues.Opacity.level4)
        case .level5:
            .blue
        }
    }
}
