//
//  UIView+.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import UIKit

extension UIView {
    //
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size),
                          afterScreenUpdates: true)
        }
    }
}
