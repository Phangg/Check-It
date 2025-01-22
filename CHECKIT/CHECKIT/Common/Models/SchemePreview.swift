//
//  SchemePreview.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI

// MARK: - 앱 스키마 미리보기 전용 구조체 (Setting 에서 사용)
struct SchemePreview: Identifiable {
    var id: UUID = .init()
    var image: UIImage?
    var text: String
    
    init(
        image: UIImage?,
        text: String
    ) {
        self.image = image
        self.text = text
    }
}
