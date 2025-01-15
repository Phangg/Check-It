//
//  AppDelegate.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import UIKit

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        //
        FirebaseApp.configure()
        //
        registerDependencies()
        return true
    }
}
