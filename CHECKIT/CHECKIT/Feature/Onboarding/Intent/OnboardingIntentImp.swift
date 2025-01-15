//
//  OnboardingIntentImp.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

final class OnboardingIntentImp {
    // Model
    private weak var model: OnboardingModelAction?
    // DI
    @Injected(OnboardingUseCase.self)
    private var onboardingUseCase: OnboardingUseCase
        
    init(
        model: OnboardingModelAction
    ) {
        self.model = model
    }
}

// MARK: - Intent
extension OnboardingIntentImp: OnboardingIntent {
    func completeOnboarding() {
        // TODO: 온보딩 완료 & 스킵 시, 자동로그인 토큰 확인
        /// 로그인 되어있으면, onboardingUseCase.completeOnboarding()
        /// 로그인 안되어있으면, LoginView 로 이동
        onboardingUseCase.completeOnboarding()
    }
    
    func showNextPage(current: OnboardingTab) {
        switch current {
        case .page1:
            model?.updateTab(.page2)
        case .page2:
            model?.updateTab(.page3)
        case .page3:
            self.completeOnboarding()
        }
    }
    
    func updateTab(_ newTab: OnboardingTab) {
        model?.updateTab(newTab)
    }
}
