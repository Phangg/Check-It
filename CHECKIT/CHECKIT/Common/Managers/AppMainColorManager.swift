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
    private var icons: [Icon] = []
    
    private init() {
        // AppStorage에 저장된 초기 색상으로 설정
        self.appMainColor = .init(brightness: appColorBrightness, baseColor: storedAppColor)
        // AppIcon 에셋들 가져오기
        fetchIcons()
    }
    
    func updateAppMainColor(to color: AppMainColor) {
        appMainColor = color
        appColorBrightness = color.brightness
        storedAppColor = color.baseColor
        updateAppIcon(to: color.baseColor)
    }
    
    private func updateAppIcon(to baseColor: Color) {
        guard UIApplication.shared.supportsAlternateIcons else {
            print("Error: AppIcon - 동적 변경 실패")
            return
        }
        let baseColorName = baseColor.description.capitalized
        let newIconName = icons.first { $0.iconName == baseColorName }?.iconName ?? icons.first?.iconName
        UIApplication.shared.setAlternateIconName(newIconName) { error in
            if let error {
                print(error.localizedDescription) // TODO: 에러 핸들링 수정 예정
            }
        }
    }
    
    private func fetchIcons() {
        if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any] {
            // Default Icon
            if let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
               let iconFileName = (primaryIcon["CFBundleIconFiles"] as? [String])?.first {
                let displayName = (primaryIcon["CFBundleIconName"] as? String) ?? ""
                icons.append(
                    Icon(
                        displayName: displayName,
                        iconName: nil,
                        image: UIImage(named: iconFileName)
                    )
                )
            }
            // Alternate Icons
            if let alternateIcons = bundleIcons["CFBundleAlternateIcons"] as? [String: Any] {
                alternateIcons.forEach { iconName, iconInfo in
                    if let iconInfo = iconInfo as? [String: Any],
                       let iconFileName = (iconInfo["CFBundleIconFiles"] as? [String])?.first {
                        icons.append(
                            Icon(
                                displayName: iconName,
                                iconName: iconName,
                                image: UIImage(named: iconFileName)
                            )
                        )
                    }
                }
            }
        }
    }
}

// AppIcon
fileprivate struct Icon {
    let displayName: String
    let iconName: String?
    let image: UIImage?
}
