//
//  LoadingIndicator.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct LoadingIndicator: View {
    @Binding private var currentPage: OnboardingTab
    
    private let color: Color
    
    init(
        currentPage: Binding<OnboardingTab>,
        color: Color
    ) {
        self._currentPage = currentPage
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: ViewValues.Padding.mid) {
            ForEach(OnboardingTab.allCases, id: \.self) { page in
                Capsule()
                    .fill(
                        color.opacity(
                            page == currentPage ? ViewValues.Opacity.level5 : ViewValues.Opacity.level3
                        )
                    )
                    .frame(
                        width: page == currentPage ? ViewValues.Size.currentIndicatorWidth : ViewValues.Size.indicator,
                        height: ViewValues.Size.indicator
                    )
                    .animation(.easeInOut(duration: ViewValues.Duration.short), value: currentPage)
            }
        }
    }
}

#Preview {
    LoadingIndicator(currentPage: .constant(.page1), color: .accent)
}
