//
//  LoginModelImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import SwiftUI

final class LoginModelImp: ObservableObject, LoginModelState {
    @Published private(set) var showWebViewSheet: Bool = false
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var showErrorAlert: Bool = false
}

// MARK: - Action
extension LoginModelImp: LoginModelAction {
    //
    func update(showWebViewSheet newValue: Bool) {
        showWebViewSheet = newValue
    }
    
    func update(showErrorAlert newValue: Bool) {
        showErrorAlert = newValue
    }
    
    func update(errorMessage newMessage: String) {
        errorMessage = newMessage
    }
}
