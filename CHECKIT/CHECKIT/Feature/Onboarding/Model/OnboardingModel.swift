//
//  OnboardingModel.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

// MARK: - State
protocol OnboardingModelState: AnyObject {
    var currentTab: OnboardingTab { get }
}

// MARK: - Action
protocol OnboardingModelAction: AnyObject {
    func updateTab(_ newTab: OnboardingTab)
}
