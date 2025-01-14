//
//  AppDelegate+RegisterDependencies.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

extension AppDelegate {

    func registerDependencies() {
        let container = AppContainer.shared
        
        // Onboarding - AppStorage "isFirstOnboarding"
        container.register(type: OnboardingUseCase.self) { _ in
            OnboardingUseCaseImp(repository: OnboardingRepositoryImp())
        }
    }
}
