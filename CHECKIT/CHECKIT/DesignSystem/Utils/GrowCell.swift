//
//  GrowCell.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct GrowCell: View {
    private let day: String
    private let month: String
    private let backgroundColor: Color
    private let type: GrowCellType
    
    init(
        day: Int? = nil,
        month: Month? = nil,
        type: GrowCellType = .default,
        backgroundColor: Color
    ) {
        self.day = if day == nil { "" } else { String(day!) }
        self.month = if month == nil { "" } else { month!.rawValue }
        self.type = type
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // BG
            RoundedRectangle(
                cornerRadius: type == .default ? ViewValues.Radius.small : ViewValues.Radius.tiny
            )
            .fill(backgroundColor)
            .frame(
                width: type == .default ? ViewValues.Size.cellBox : ViewValues.Size.cellBoxSmall,
                height: type == .default ? ViewValues.Size.cellBox : ViewValues.Size.cellBoxSmall
            )
            // Label
            Text(day != "" ? day : month)
                .font(.system(size: day != "" ? 15 : 13)) // TODO: font 수정 예정
                .fontWeight(.regular)
                .foregroundStyle(day != "" ? .budWhite : .budBlack)
        }
    }
}

#Preview {
    VStack(alignment: .center, spacing: ViewValues.Padding.default) {
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            GrowCell(day: 1, backgroundColor: .cellLevel1)
            GrowCell(day: 2, backgroundColor: .blue.opacity(ViewValues.Opacity.level2))
            GrowCell(day: 3, backgroundColor: .blue.opacity(ViewValues.Opacity.level3))
            GrowCell(day: 4, backgroundColor: .blue.opacity(ViewValues.Opacity.level4))
            GrowCell(day: 5, backgroundColor: .blue)
        }
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            GrowCell(backgroundColor: .cellLevel1)
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level2))
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level3))
            GrowCell(backgroundColor: .blue.opacity(ViewValues.Opacity.level4))
            GrowCell(backgroundColor: .blue)
        }
    }
}
