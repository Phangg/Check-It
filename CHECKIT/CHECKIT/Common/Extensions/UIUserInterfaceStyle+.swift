//
//  UIUserInterfaceStyle+.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import UIKit

extension UIUserInterfaceStyle {
    var oppsiteInterfaceStyle: UIUserInterfaceStyle {
        return self == .dark ? .light : .dark
    }
}
