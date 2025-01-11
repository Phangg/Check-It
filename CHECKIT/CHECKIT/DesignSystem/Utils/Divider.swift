//
//  Divider.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color
    let type: DividerType
    
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
    CustomDivider(
        color: .gray, // TODO: color 수정 필요
        type: .horizontal()
    )
    .padding(ViewValues.Padding.default)
}
