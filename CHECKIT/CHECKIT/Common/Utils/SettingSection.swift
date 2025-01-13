//
//  SettingSection.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

enum SettingSection: String, CaseIterable {
    case notification = "Notification"
    case styleAndTheme = "Style & Theme"
    case information = "Information"
    case support = "Support"
    case account = "Account"

    var items: [SettingItem] {
        switch self {
        case .notification:
            return [.notification]
        case .styleAndTheme:
            return [.appMainColor, .displayMode]
        case .information:
            return [.privacyPolicy, .termsAndConditions]
        case .support:
            return [.appEvaluation, .request]
        case .account:
            return [.logout, .cancelAccount]
        }
    }
}
