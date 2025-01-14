//
//  OnboardingModelImp.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import Foundation

final class OnboardingModelImp: ObservableObject, OnboardingModelState {
    @Published private(set) var currentTab: OnboardingTab = .page1
}

// MARK: - Action
extension OnboardingModelImp: OnboardingModelAction {
    func updateTab(_ newTab: OnboardingTab) {
        currentTab = newTab
    }
}
