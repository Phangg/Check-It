//
//  AppVersion.swift
//  CHECKIT
//
//  Created by phang on 1/28/25.
//

import Foundation

struct AppVersion {
    // 앱 버전
    static let appVersion: String = {
        guard let dictionary = Bundle.main.infoDictionary,
              let appVersion = dictionary["CFBundleShortVersionString"] as? String
        else {
            return "-"
        }
        return String(appVersion.reversed())
    }()
    
    // 빌드 버전
    static let buildVersion: String = {
        guard let dictionary = Bundle.main.infoDictionary,
              let buildVersion = dictionary["CFBundleVersion"] as? String
        else {
            return "?"
        }
        return buildVersion
    }()
}
