//
//  GrowCellType.swift
//  CHECKIT
//
//  Created by phang on 1/15/25.
//

import SwiftUI

enum GrowCellType {
    case `default`
    case small
    
    var size: CGFloat {
        switch self {
        case .default:
            ViewValues.Size.cellBox
        case .small:
            ViewValues.Size.cellBoxSmall
        }
    }
}
