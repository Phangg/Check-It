//
//  SplashModelImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

final class SplashModelImp: ObservableObject, SplashModelState{
    @Published private(set) var animationActive: Bool = false
}

// MARK: - Action
extension SplashModelImp: SplashModelAction {
    func update(animationActive newValue: Bool) {
        animationActive = newValue
    }
}
