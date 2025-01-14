//
//  OnboardingRepositoryImp.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import SwiftUI

final class OnboardingRepositoryImp: OnboardingRepository {
    @AppStorage(AppStorageKeys.isFirstOnboarding)
    private var isFirstOnboardingData: Bool = true
    
//    var isFirstOnboarding: Bool {
//        isFirstOnboardingData
//    }
    
    func setIsFirstOnboarding(_ value: Bool) {
        isFirstOnboardingData = value
    }
}
