//
//  Divider.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct CustomDivider: View {
    private let color: Color
    private let type: DividerType
    
    init(
        color: Color = .cellLevel1,
        type: DividerType = .horizontal()
    ) {
        self.color = color
        self.type = type
    }
    
    var body: some View {
        switch type {
        case .horizontal(let height):
            color
                .frame(height: height)
        case .vertival(let width):
            color
                .frame(width: width)
        }
    }
}

#Preview {
    CustomDivider()
        .padding(ViewValues.Padding.default)
}
