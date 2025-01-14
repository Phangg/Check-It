//
//  OnboardingIntent.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

protocol OnboardingIntent: AnyObject {
    func completeOnboarding()
    func showNextPage(current: OnboardingTab)
    func updateTab(_ newTab: OnboardingTab)
}
