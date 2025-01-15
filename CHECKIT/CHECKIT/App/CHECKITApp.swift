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

    @AppStorage(AppStorageKeys.isFirstOnboarding)
    private var isFirstOnboarding: Bool = true
    
    @State private var isNotLogin: Bool = true // TODO: 로그인 정보 토큰 확인 키체인으로 수정 예정
    
    var body: some Scene {
        WindowGroup {
            if isFirstOnboarding {
                // 앱 최초 실행 시, 온보딩화면을 띄우기
                OnboardingView()
                    // TODO: 추후 키체인 코드, 로그인 코드 작성 시 다시 사용 예정
//                    .sheet(isPresented: $isNotLogin) {
//                        Loginview()
//                            .presentationDragIndicator(.visible)
//                    }
            } else {
                // 메인 화면
                MainView()
            }
        }
    }
}
