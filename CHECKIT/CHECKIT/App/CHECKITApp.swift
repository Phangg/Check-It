//
//  CHECKITApp.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

@main
struct CHECKITApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var appMainColorManager = AppMainColorManager.shared

    @AppStorage(AppStorageKeys.isFirstOnboarding)
    private var isFirstOnboarding: Bool = true
    
    @State private var isFetched: Bool = false
    @State private var isLoggedOut: Bool = true // TODO: 로그인 정보 토큰 확인 키체인으로 수정 예정
    
    var body: some Scene {
        WindowGroup {
            if !isFetched {
                // 데이터 받아오는 동안, Splash 화면
                SplashView(isFetched: $isFetched)
            } else if isFirstOnboarding {
                // 앱 최초 실행 시, 온보딩화면을 띄우기
                OnboardingView()
//                    // TODO: 추후 키체인 코드, 로그인 코드 작성 시 다시 사용 예정
//                    .sheet(isPresented: $isLoggedOut) {
//                        Loginview()
//                            .presentationDragIndicator(.visible)
//                    }
            } else {
                // 메인 화면
                MainView()
            }
        }
        //
        .environmentObject(themeManager)
        .onChange(of: themeManager.currentScheme) { _, newScheme in
            themeManager.updateAppearance(to: newScheme)
        }
        //
        .environmentObject(appMainColorManager)
    }
}
