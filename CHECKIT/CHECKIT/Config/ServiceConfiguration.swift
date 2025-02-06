//
//  ServiceConfiguration.swift
//  CHECKIT
//
//  Created by phang on 2/6/25.
//

import Foundation

// MARK: - Config
struct ServiceConfiguration {
    //
    static var supportEmail: String {
        guard let email = Bundle.main.object(forInfoDictionaryKey: "SUPPORT_EMAIL") as? String else {
            fatalError("⚠️ Config Error - ServiceConfiguration: supportEmail")
        }
        return email
    }
}
