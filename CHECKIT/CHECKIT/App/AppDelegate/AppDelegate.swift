//
//  AppDelegate.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        registerDependencies()
        return true
    }
}
