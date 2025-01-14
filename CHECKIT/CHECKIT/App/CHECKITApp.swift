//
//  CHECKITApp.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

@main
struct CHECKITApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    @AppStorage(AppStorageKeys.isFirstOnboarding) private var isFirstOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstOnboarding {
                // 앱 최초 실행 시, 온보딩화면을 띄우기
                OnboardingView()
            } else {
                // 메인 화면
                MainView()
            }
        }
    }
}
