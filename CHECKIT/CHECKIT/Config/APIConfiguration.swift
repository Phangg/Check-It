//
//  APIConfiguration.swift
//  CHECKIT
//
//  Created by phang on 2/6/25.
//

import Foundation

// MARK: - Config
struct APIConfiguration {
    //
    static var baseURL: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("⚠️ Config Error - ServiceConfiguration: baseURL")
        }
        return baseUrl
    }
}
