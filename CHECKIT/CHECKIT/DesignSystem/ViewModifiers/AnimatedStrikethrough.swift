//
//  AnimatedStrikethrough.swift
//  CHECKIT
//
//  Created by phang on 1/11/25.
//

import SwiftUI

struct AnimatedStrikethrough: ViewModifier {
    @State private var width: CGFloat = 0

    private let isActive: Bool
    private let color: Color
    private let height: CGFloat
    private let duration: Double
        
    init(
        isActive: Bool,
        color: Color,
        height: CGFloat,
        duration: Double
    ) {
        self.isActive = isActive
        self.color = color
        self.height = height
        self.duration = duration
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(color)
                            .frame(width: isActive ? geometry.size.width : 0, height: height)
                            .offset(y: (geometry.size.height / 2))
                    }
                }
            )
            .animation(.easeInOut(duration: duration), value: isActive)
    }
}
