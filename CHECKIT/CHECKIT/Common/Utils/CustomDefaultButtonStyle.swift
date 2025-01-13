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
    
    // TODO: color 수정 필요
    var foregroundColor: Color {
        switch self {
        case .filled:
                .budWhite
        case .bordered:
                .blue
        }
    }
    
    // TODO: color 수정 필요
    var backgroundColor: Color {
        switch self {
        case .filled:
                .blue
        case .bordered:
                .budWhite
        }
    }
}
