//
//  OnboardingView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentTab: OnboardingTab = .page1
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
            //
            OnboardingTopToobar()
                .padding(ViewValues.Padding.default)
            //
            OnboardingPage(currentTab: $currentTab)
            //
            CustomDefaultButton(
                style: .filled,
                text: currentTab.nextButtonText
            ) {
                switch currentTab {
                case .page1:
                    currentTab = .page2
                case .page2:
                    currentTab = .page3
                case .page3:
                    break
                    // TODO: 온보딩 완료하고 MainView 로 이동
                }
            }
            .padding(ViewValues.Padding.default)
        }
    }
    
    @ViewBuilder
    fileprivate func OnboardingTopToobar() -> some View {
        HStack(alignment: .center) {
            //
            LoadingIndicator(currentPage: $currentTab, color: .blue) // TODO: color 수정 예정
            //
            Spacer()
            // Skip 버튼
            Button {
                //
            } label: {
                HStack(alignment: .center, spacing: ViewValues.Padding.mid) {
                    Text("Skip") // TODO: font 수정 예정
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                Image(systemName: "chevron.right")
            }
            .tint(.blue) // TODO: color 수정 예정

        }
        .frame(height: ViewValues.Size.onboardingTopToobarHeight)
    }
}
