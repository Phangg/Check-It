//
//  LoadingIndicator.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct LoadingIndicator: View {
    @Binding private var currentStep: Int
    
    private let color: Color
    
    init(
        currentStep: Binding<Int>,
        color: Color
    ) {
        self._currentStep = currentStep
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: ViewValues.Padding.mid) {
            ForEach(0..<3, id: \.self) { step in
                if step == currentStep {
                    // 완료된 단계
                    Capsule()
                        .fill(color)
                        .frame(width: 50, height: 10)
                } else {
                    // 남은 단계
                    Circle()
                        .fill(color.opacity(ViewValues.Opacity.level3))
                        .frame(width: 10, height: 10)
                }
            }
        }
    }
}

#Preview {
    LoadingIndicator(currentStep: .constant(0), color: .blue)
}
