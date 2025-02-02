//
//  SplashModel.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

// MARK: - State
protocol SplashModelState: AnyObject {
    var animationActive: Bool { get }
}

// MARK: - Action
protocol SplashModelAction: AnyObject {
    func update(animationActive newValue: Bool)
}
