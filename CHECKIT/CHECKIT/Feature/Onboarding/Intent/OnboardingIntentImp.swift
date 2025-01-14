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
