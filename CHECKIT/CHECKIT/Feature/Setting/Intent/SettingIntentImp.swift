//
//  SettingIntentImp.swift
//  CHECKIT
//
//  Created by phang on 2/1/25.
//

import Foundation
import Combine

final class SettingIntentImp {
    // Model
    private weak var model: SettingModelAction?
        
    init(
        model: SettingModelAction
    ) {
        self.model = model
    }
    
    private func openAlert(errorMessage: String) {
        model?.update(errorMessage: errorMessage)
        update(showErrorAlert: true)
    }
    
    private func openWebView(url: URL) {
        model?.update(selectedWebViewURL: url)
        model?.update(showWebViewSheet: true)
    }
}

// MARK: - Intent
extension SettingIntentImp: SettingIntent {
    @MainActor
    func handleTapDisplayMode() {
        Task {
            await model?.generateSchemePreviews(currentScheme: ThemeManager.currentSystemInterfaceStyle)
            update(showSchemePicker: true)
        }
    }
    
    func handleOnAppear() {
        model?.prepareOverlayWindow() // 앱 스키마 스크린샷을 위한 준비
    }
    
    func validateAndPresentWebView(url: URL?) {
        guard let url = url, url.isValid() else {
            openAlert(errorMessage: "잘못된 URL 입니다.")
            return
        }
        openWebView(url: url)
    }
    
    func validateURLOrShowAlert(url: URL?) -> URL? {
        guard let url = url else {
            openAlert(errorMessage: "잘못된 URL 입니다.")
            return nil
        }
        return url
    }
    
    //
    func update(isOnNotification newValue: Bool) {
        model?.update(isOnNotification: newValue)
    }
    
    func update(showColorPicker newValue: Bool) {
        model?.update(showColorPicker: newValue)
    }
    
    func update(showSchemePicker newValue: Bool) {
        model?.update(showSchemePicker: newValue)
    }
    
    func update(showWebViewSheet newValue: Bool) {
        model?.update(showWebViewSheet: newValue)
    }
    
    func update(showErrorAlert newValue: Bool) {
        model?.update(showErrorAlert: newValue)
    }
    
    func update(schemePreviews newPreviews: [SchemePreview]) {
        model?.update(schemePreviews: newPreviews)
    }
    
    func update(selectedWebViewURL newURL: URL?) {
        model?.update(selectedWebViewURL: newURL)
    }
    
    func update(errorMessage newMessage: String) {
        model?.update(errorMessage: newMessage)
    }
}
