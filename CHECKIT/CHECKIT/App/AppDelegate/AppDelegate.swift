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
        // Scheme 체크
        #if DEBUG
        print("🐞 It's DEBUG APP")
        #else
        print("✨ It's RELEASE APP")
        #endif
        // Alert 버튼 색상 수정 (.default & .cancel)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .budBlack
        //
        FirebaseApp.configure()
        //
        registerDependencies()
        return true
    }
}
