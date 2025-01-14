//
//  OnboardingUseCaseImp.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import Combine

final class OnboardingUseCaseImp: ObservableObject, OnboardingUseCase {
    private let repository: OnboardingRepository
    
//    var isFirstOnboarding: Bool {
//        repository.isFirstOnboarding
//    }

    init(
        repository: OnboardingRepository
    ) {
        self.repository = repository
    }
        
    func completeOnboarding() {
        repository.setIsFirstOnboarding(false)
    }
}
