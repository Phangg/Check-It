//
//  URL+.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import UIKit

extension URL {
    //
    func isValid() -> Bool {
        UIApplication.shared.canOpenURL(self)
    }
}
