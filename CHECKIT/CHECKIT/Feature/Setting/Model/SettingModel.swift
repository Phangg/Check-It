//
//  SettingModel.swift
//  CHECKIT
//
//  Created by phang on 2/1/25.
//

import UIKit

// MARK: - State
protocol SettingModelState: AnyObject {
    var isOnNotification: Bool { get }
    var showSchemePicker: Bool { get }
    var schemePreviews: [SchemePreview] { get }
    var overlayWindow: UIWindow? { get }
    var showColorPicker: Bool { get }
    var selectedWebViewURL: URL? { get }
    var showWebViewSheet: Bool { get }
    var errorMessage: String { get }
    var showErrorAlert: Bool { get }
}

// MARK: - Action
protocol SettingModelAction: AnyObject {
    @MainActor func generateSchemePreviews(currentScheme: UIUserInterfaceStyle) async
    func prepareOverlayWindow() // 앱 스키마 스크린샷을 위한 준비
    //
    func update(isOnNotification newValue: Bool)
    func update(showColorPicker newValue: Bool)
    func update(showSchemePicker newValue: Bool)
    func update(showWebViewSheet newValue: Bool)
    func update(showErrorAlert newValue: Bool)
    func update(schemePreviews newPreviews: [SchemePreview])
    func update(selectedWebViewURL newURL: URL?)
    func update(errorMessage newMessage: String)
}
