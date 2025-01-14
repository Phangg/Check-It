//
//  OnboardingPage.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import SwiftUI

struct OnboardingPage: View {
    @Binding private var currentTab: OnboardingTab
    
    init(
        currentTab: Binding<OnboardingTab>
    ) {
        self._currentTab = currentTab
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(OnboardingTab.allCases, id: \.self) { page in
                Page(page)
                    .tag(page)
            }
        }
        .animation(.easeInOut(duration: ViewValues.Duration.regular), value: currentTab)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    @ViewBuilder
    fileprivate func Page(_ page: OnboardingTab) -> some View {
        VStack(alignment: .center, spacing: ViewValues.Padding.zero) {
            // Title & Description
            VStack(alignment: .center, spacing: ViewValues.Padding.default) {
                Text(page.title) // TODO: font 수정 예정
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .foregroundStyle(.budBlack)
                Text(page.description) // TODO: font 수정 예정
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundStyle(.budBlack)
            }
            .frame(width: ViewValues.Size.onboardingContentWidth)
            //
            Spacer(minLength: ViewValues.Padding.big)
            // Image
            Rectangle() // TODO: 이미지로 변경 예정
                .fill(.pink)
                .frame(width: ViewValues.Size.onboardingContentWidth,
                       height: ViewValues.Size.onboardingContentWidth)
        }
        .padding(.vertical, ViewValues.Padding.default)
    }
}
