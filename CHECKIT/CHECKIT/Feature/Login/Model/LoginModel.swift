//
//  LoginModel.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

// MARK: - State
protocol LoginModelState: AnyObject {
    var showWebViewSheet: Bool { get }
    var errorMessage: String { get }
    var showErrorAlert: Bool { get }
}

// MARK: - Action
protocol LoginModelAction: AnyObject {
    //
    func update(showWebViewSheet newValue: Bool)
    func update(showErrorAlert newValue: Bool)
    func update(errorMessage newMessage: String)
}
