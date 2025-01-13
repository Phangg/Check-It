//
//  GrowCell.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct GrowCell: View {
    private let day: String
    private let backgroundColor: Color
    
    init(
        day: Int? = nil,
        backgroundColor: Color
    ) {
        self.day = if day == nil { "" } else { String(day!) }
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // BG
            RoundedRectangle(cornerRadius: ViewValues.Radius.small)
                .fill(backgroundColor)
                .frame(width: ViewValues.Size.cellBox, height: ViewValues.Size.cellBox)
            // Label
            Text(day)  // TODO: 폰트 설정 필요
                .foregroundStyle(.white) // TODO: color 수정 필요
        }
    }
}

#Preview {
    // TODO: color 수정 필요
    VStack(alignment: .center, spacing: ViewValues.Padding.default) {
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            GrowCell(day: 1, backgroundColor: .gray.opacity(0.3))
            GrowCell(day: 2, backgroundColor: .blue.opacity(ViewValues.Opacity.level2))
            GrowCell(day: 3, backgroundColor: .blue.opacity(ViewValues.Opacity.level3))
            GrowCell(day: 4, backgroundColor: .blue.opacity(ViewValues.Opacity.level4))
            GrowCell(day: 5, backgroundColor: .blue)
        }
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            GrowCell(backgroundColor: .gray.opacity(0.3))
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level2))
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level3))
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level4))
            GrowCell(backgroundColor: .blue)
        }
    }
}
