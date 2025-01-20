//
//  SettingView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isOnNotification: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: ViewValues.Padding.zero) {
                //
                List {
                    // Section
                    ForEach(SettingSection.allCases, id: \.self) { section in
                        Section {
                            // Items
                            ForEach(section.items, id: \.self) { item in
                                SettingListItemCell(
                                    isOnNotification: item == .notification ? $isOnNotification : nil,
                                    item: item
                                )
                            }
                        } header: {
                            Text(section.rawValue)
                                .font(.system(size: 16)) // TODO: font 수정 예정
                                .fontWeight(.medium)
                                .foregroundStyle(.budBlack)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { SettingViewToolbarContent() }
        }
    }
    
    @ToolbarContentBuilder
    fileprivate func SettingViewToolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(AppLocalized.SettingSheetTitle)
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.semibold)
                .foregroundStyle(.budBlack)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .tint(.budBlack)
        }
    }
}
