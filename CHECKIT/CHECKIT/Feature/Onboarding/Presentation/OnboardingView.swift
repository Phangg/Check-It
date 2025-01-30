//
//  OnboardingView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @StateObject var container: MVIContainer<OnboardingIntent, OnboardingModelState>
    private var intent: OnboardingIntent { container.intent }
    private var state: OnboardingModelState { container.model }
        
    init() {
        let model = OnboardingModelImp()
        let intent = OnboardingIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as OnboardingIntent,
            model: model as OnboardingModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
            //
            OnboardingTopToobar()
                .padding(.horizontal, ViewValues.Padding.default)
            //
            OnboardingPage(
                currentTab: Binding(
                    get: { state.currentTab },
                    set: { intent.updateTab($0) }
                )
            )
            .padding(.vertical, ViewValues.Padding.medium)
            //
            CustomDefaultButton(
                style: .filled,
                text: state.currentTab.nextButtonText
            ) {
                intent.showNextPage(current: state.currentTab)
            }
            .padding(.horizontal, ViewValues.Padding.large)
            .padding(.vertical, ViewValues.Padding.default)
        }
    }
    
    @ViewBuilder
    private func OnboardingTopToobar() -> some View {
        HStack(alignment: .center) {
            // OnboardingPage 인디케이터
            LoadingIndicator(
                currentPage: Binding(
                    get: { state.currentTab },
                    set: { intent.updateTab($0) }
                ),
                color: appMainColorManager.appMainColor.mainColor
            )
            //
            Spacer()
            // Skip 버튼
            Button {
                intent.completeOnboarding()
            } label: {
                HStack(alignment: .center, spacing: ViewValues.Padding.mid) {
                    Text("Skip") // TODO: font 수정 예정
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                Image(systemName: "chevron.right")
            }
            .tint(appMainColorManager.appMainColor.mainColor)

        }
        .frame(height: ViewValues.Size.onboardingTopToobarHeight)
    }
}
