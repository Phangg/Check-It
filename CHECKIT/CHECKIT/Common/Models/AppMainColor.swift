//
//  AppMainColor.swift
//  CHECKIT
//
//  Created by phang on 1/24/25.
//

import SwiftUI

struct AppMainColor: Equatable {
    var mainColor: Color
    var brightness: CGFloat
    var baseColor: Color
    
    init(
        brightness: CGFloat,
        baseColor: Color
    ) {
        self.mainColor = baseColor.adjust(brightness: brightness)
        self.brightness = brightness
        self.baseColor = baseColor
    }
}
