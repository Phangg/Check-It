//
//  Gesture+.swift
//  CHECKIT
//
//  Created by phang on 1/31/25.
//

import SwiftUI

extension Gesture {
    func whenCondition(_ condition: Bool) -> some Gesture {
        return condition ? self : nil
    }
}
