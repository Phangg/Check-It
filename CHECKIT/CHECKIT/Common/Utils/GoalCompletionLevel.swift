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
        let mainColor = AppMainColorManager.shared.appMainColor.mainColor
        //
        switch self {
        case .level1:
            return .cellLevel1
        case .level2:
            return mainColor.opacity(ViewValues.Opacity.level2)
        case .level3:
            return mainColor.opacity(ViewValues.Opacity.level3)
        case .level4:
            return mainColor.opacity(ViewValues.Opacity.level4)
        case .level5:
            return mainColor
        }
    }
}
