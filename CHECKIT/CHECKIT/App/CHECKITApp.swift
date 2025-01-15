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
    
    @State private var isNotLogin: Bool = true // TODO: 로그인 정보 확인 여부 로컬 데이터로 수정 예정
    
    var body: some Scene {
        WindowGroup {
            if isFirstOnboarding {
                // 앱 최초 실행 시, 온보딩화면을 띄우기
                OnboardingView()
            } else {
                // 메인 화면
                MainView()
                    // TODO: 추후에 OnboardingView 의 시트로 이동 예정
                    // TODO: 온보딩 완료, 스킵 시 -> 로그인 안되어있으면 LoginView 보이도록 하기
//                    .sheet(isPresented: $isNotLogin) {
//                        Loginview()
//                            .presentationDragIndicator(.visible)
//                    }
            }
        }
    }
}
