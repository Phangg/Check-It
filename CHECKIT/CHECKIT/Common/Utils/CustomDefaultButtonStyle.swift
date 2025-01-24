//
//  CustomDefaultButtonStyle.swift
//  CHECKIT
//
//  Created by phang on 1/11/25.
//

import SwiftUI

enum CustomDefaultButtonStyle {
    case filled
    case bordered
    
    var foregroundColor: Color {
        switch self {
        case .filled:
            .budWhite
        case .bordered:
            AppMainColorManager.shared.appMainColor.mainColor
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .filled:
            AppMainColorManager.shared.appMainColor.mainColor
        case .bordered:
            .budWhite
        }
    }
}
