//
//  AppMainColorManager.swift
//  CHECKIT
//
//  Created by phang on 1/24/25.
//

import SwiftUI

final class AppMainColorManager: ObservableObject {
    static let shared = AppMainColorManager()
    
    @AppStorage(AppStorageKeys.appMainColor)
    private var storedAppColor: Color = .accent
    @AppStorage(AppStorageKeys.appMainColorBrightness)
    private var appColorBrightness: Double = 0
    
    @Published var appMainColor: AppMainColor = .init(brightness: 0, baseColor: .accent)
    
    
    private init() {
        // AppStorage에 저장된 초기 색상으로 설정
        self.appMainColor = .init(brightness: appColorBrightness, baseColor: storedAppColor)
    }
    
    func updateAppMainColor(to color: AppMainColor) {
        appMainColor = color
        appColorBrightness = color.brightness
        storedAppColor = color.baseColor
    }
}
