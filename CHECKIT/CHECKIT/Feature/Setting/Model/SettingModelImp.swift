//
//  SettingModelImp.swift
//  CHECKIT
//
//  Created by phang on 2/1/25.
//

import UIKit

final class SettingModelImp: ObservableObject, SettingModelState {
    @Published private(set) var isOnNotification: Bool = false
    @Published private(set) var showSchemePicker: Bool = false
    @Published private(set) var schemePreviews: [SchemePreview] = []
    @Published private(set) var overlayWindow: UIWindow? = nil
    @Published private(set) var showColorPicker: Bool = false
    @Published private(set) var selectedWebViewURL: URL? = nil
    @Published private(set) var showWebViewSheet: Bool = false
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var showErrorAlert: Bool = false
    
    private func showOverlayImageView(_ image: UIImage?) {
        removeOverlayImageView()
        //
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            overlayWindow?.rootViewController?.view.addSubview(imageView)
        }
    }
    
    private func removeOverlayImageView() {
        overlayWindow?.rootViewController?.view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

// MARK: - Action
extension SettingModelImp: SettingModelAction {
    @MainActor
    func generateSchemePreviews(currentScheme: UIUserInterfaceStyle) async {
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow,
               schemePreviews.isEmpty {
                let size = window.screen.bounds.size
                let defaultStyle = window.overrideUserInterfaceStyle
                // 현재 스키마 이미지
                let defautSchemePreview = window.image(size)
                schemePreviews.append(
                    .init(
                        image: defautSchemePreview,
                        text: currentScheme == .dark ? AppScheme.dark.rawValue : AppScheme.light.rawValue
                    )
                )
                // overlayWindow 에 이미지 표시
                showOverlayImageView(defautSchemePreview)
                // 반대 스키마로 변경
                window.overrideUserInterfaceStyle = currentScheme.oppsiteInterfaceStyle
                // 반대 스키마 이미지
                let otherSchemePreviewImage = window.image(size)
                schemePreviews.append(
                    .init(
                        image: otherSchemePreviewImage,
                        text: currentScheme == .dark ? AppScheme.light.rawValue : AppScheme.dark.rawValue
                    )
                )
                // 다크모드의 경우 순서 바꾸기
                if currentScheme == .dark {
                    schemePreviews = schemePreviews.reversed()
                }
                // 스키마 복구
                window.overrideUserInterfaceStyle = defaultStyle
                try? await Task.sleep(for: .seconds(0))
                // overlayWindow 에 이미지 제거
                removeOverlayImageView()
            }
        }
    }
    
    func prepareOverlayWindow() {
        if let scene = (UIApplication.shared.connectedScenes.first as? UIWindowScene),
           overlayWindow == nil {
            let window = UIWindow(windowScene: scene)
            window.backgroundColor = .clear
            window.isHidden = false
            window.isUserInteractionEnabled = false
            let emptyController = UIViewController()
            emptyController.view.backgroundColor = .clear
            window.rootViewController = emptyController
            overlayWindow = window
        }
    }
    
    func update(isOnNotification newValue: Bool) {
        isOnNotification = newValue
    }
    
    func update(showColorPicker newValue: Bool) {
        showColorPicker = newValue
    }
    
    func update(showSchemePicker newValue: Bool) {
        showSchemePicker = newValue
    }
    
    func update(showWebViewSheet newValue: Bool) {
        showWebViewSheet = newValue
    }
    
    func update(showErrorAlert newValue: Bool) {
        showErrorAlert = newValue
    }
    
    func update(schemePreviews newPreviews: [SchemePreview]) {
        schemePreviews = newPreviews
    }
    
    func update(selectedWebViewURL newURL: URL?) {
        selectedWebViewURL = newURL
    }
    
    func update(errorMessage newMessage: String) {
        errorMessage = newMessage
    }
}
