//
//  ThemeManager.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @AppStorage("AppScheme") private var storedAppScheme: AppScheme = .device
    @Published var currentScheme: AppScheme = .device
    
    private init() {
        // AppStorage에 저장된 초기 테마로 설정
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentScheme = self.storedAppScheme
            self.applyScheme(self.currentScheme)
        }
    }
    
    func updateAppearance(to scheme: AppScheme) {
        currentScheme = scheme
        storedAppScheme = scheme // 저장
        applyScheme(scheme) // 반영
    }
    
    private func applyScheme(_ scheme: AppScheme) {
        guard let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow else { return }
        
        window.overrideUserInterfaceStyle = {
            switch scheme {
            case .dark:
                .dark
            case .light:
                .light
            case .device:
                .unspecified
            }
        }()
    }
    
    // 현재 모드 확인
    static var currentSystemInterfaceStyle: UIUserInterfaceStyle {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return scene.windows.first?.traitCollection.userInterfaceStyle ?? .unspecified
        }
        return .unspecified
    }
}
