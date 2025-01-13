//
//  ViewValues.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct ViewValues {
    //
    struct Padding {
        static let `default`: CGFloat = 20
        static let medium: CGFloat = 10
        static let mid: CGFloat = 6
        static let small: CGFloat = 4
        static let tiny: CGFloat = 2
    }
    
    //
    struct Size {
        static let defaultButtonHeight: CGFloat = 60
        static let goalCellHeight: CGFloat = 70
        static let lineWidth: CGFloat = 0.35
        static let cellBox: CGFloat = 30
        static let cellBoxSmall: CGFloat = 20
        static let streakImageHeight: CGFloat = 22
    }
    
    //
    struct Radius {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 14
        static let `default`: CGFloat = 20
    }
    
    //
    struct Scale {
        static let pressed: CGFloat = 0.97
        static let `default`: CGFloat = 1.0
    }
    
    //
    struct Duration {
//        static let short: Double =
        static let regular: Double = 0.15
        static let long: Double = 0.3
    }
    
    //
    struct Opacity {
        static let light: CGFloat = 0.05
        static let level2: CGFloat = 0.25
        static let level3: CGFloat = 0.5
        static let level4: CGFloat = 0.75
    }
}
