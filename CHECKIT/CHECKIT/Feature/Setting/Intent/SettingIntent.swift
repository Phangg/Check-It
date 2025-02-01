//
//  SettingIntent.swift
//  CHECKIT
//
//  Created by phang on 2/1/25.
//

import Foundation

protocol SettingIntent: AnyObject {
    @MainActor func handleTapDisplayMode()
    func handleOnAppear()
    func validateAndPresentWebView(url: URL?)
    func validateURLOrShowAlert(url: URL?) -> URL?
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
