//
//  LoginIntentImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

final class LoginIntentImp {
    // Model
    private weak var model: LoginModelAction?
        
    init(
        model: LoginModelAction
    ) {
        self.model = model
    }
    
    private func openAlert() {
        model?.update(showErrorAlert: true)
    }
    
    private func openWebView() {
        model?.update(showWebViewSheet: true)
    }
}

// MARK: - Intent
extension LoginIntentImp: LoginIntent {
    func dismissWebView(isErrorMessageEmpty: Bool) {
        guard !isErrorMessageEmpty else { return }
        openAlert()
    }
    
    func openPrivacyPolicyWebView(url: URL?) {
        guard let url = url, url.isValid() else {
            model?.update(errorMessage: "잘못된 URL 입니다.")
            openAlert()
            return
        }
        openWebView()
    }
    
    //
    func update(showWebViewSheet newValue: Bool) {
        model?.update(showWebViewSheet: newValue)
    }
    
    func update(showErrorAlert newValue: Bool) {
        model?.update(showErrorAlert: newValue)
    }
    
    func update(errorMessage newMessage: String) {
        model?.update(errorMessage: newMessage)
    }
}
