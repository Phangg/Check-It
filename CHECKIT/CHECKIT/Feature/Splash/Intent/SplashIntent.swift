//
//  SplashIntent.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

protocol SplashIntent: AnyObject {
    @MainActor func handleOnAppear()
}
