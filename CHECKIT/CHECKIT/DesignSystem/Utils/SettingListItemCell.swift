//
//  SettingListItemCell.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct SettingListItemCell: View {
    @Binding private var isOnNotification: Bool
    
    private let item: SettingItem
    
    init(
        isOnNotification: Binding<Bool>? = nil,
        item: SettingItem
    ) {
        self._isOnNotification = if let isOnNotification { isOnNotification } else { .constant(false) }
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: ViewValues.Padding.default) {
            // image
            Image(systemName: item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ViewValues.Size.settingItemImage, height: ViewValues.Size.settingItemImage)
                .foregroundStyle(item == .cancelAccount ? .red : .budBlack) // TODO: color 수정 예정
            // title & subtitle
            VStack(alignment: .leading, spacing: ViewValues.Padding.small) {
                Text(item.title) // TODO: 폰트 설정 필요
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundStyle(item == .cancelAccount ? .red : .budBlack) // TODO: color 수정 예정
                if let subtitle = item.subtitle {
                    Text(subtitle) // TODO: 폰트 설정 필요
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundStyle(.midGray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //
            Spacer(minLength: ViewValues.Padding.medium)
            // trail icon
            switch item.type {
            case .toggle:
                Toggle("", isOn: $isOnNotification)
                    .labelsHidden()
                    .tint(.blue) // TODO: color 수정 예정
            case .sheet, .web, .store, .mail:
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ViewValues.Size.settingItemTrailImage, height: ViewValues.Size.settingItemTrailImage)
                    .foregroundStyle(.midGray)
            case .none:
                EmptyView()
            }
        }
        .frame(height: ViewValues.Size.settingItemHeight)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
        List {
            ForEach(SettingSection.allCases, id: \.self) { section in
                Section {
                    //
                    ForEach(section.items, id: \.self) { item in
                        SettingListItemCell(
                            isOnNotification: item == .notification ? .constant(true) : nil,
                            item: item
                        )
                    }
                } header: {
                    Text(section.rawValue) // TODO: 폰트 설정 필요
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.budBlack)
                }
            }
        }
        .listStyle(.plain)
    }
}
