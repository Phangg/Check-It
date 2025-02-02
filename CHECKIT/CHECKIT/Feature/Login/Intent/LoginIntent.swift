//
//  LoginIntent.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

protocol LoginIntent: AnyObject {
    func dismissWebView(isErrorMessageEmpty: Bool)
    func openPrivacyPolicyWebView(url: URL?)
    //
    func update(showWebViewSheet newValue: Bool)
    func update(showErrorAlert newValue: Bool)
    func update(errorMessage newMessage: String)
}
