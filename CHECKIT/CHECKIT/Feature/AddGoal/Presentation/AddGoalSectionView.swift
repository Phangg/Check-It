//
//  AddGoalSectionView.swift
//  CHECKIT
//
//  Created by phang on 1/19/25.
//

import SwiftUI

struct AddGoalSectionView<Content: View>: View {
    let title: String
    let isRequired: Bool
    let description: String?
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.medium) {
            VStack(alignment: .leading, spacing: ViewValues.Padding.small) {
                HStack(alignment: .center, spacing: ViewValues.Padding.tiny) {
                    if isRequired {
                        Text("*")
                            .font(.system(size: 13)) // TODO: 폰트 설정 필요
                            .foregroundStyle(.red)
                    }
                    Text(title)
                        .font(.system(size: 16)) // TODO: 폰트 설정 필요
                        .fontWeight(.regular)
                        .foregroundStyle(.budBlack)
                }
                if let description = description {
                    Text(description)
                        .font(.system(size: 13)) // TODO: 폰트 설정 필요
                        .fontWeight(.regular)
                        .foregroundStyle(.midGray)
                }
            }
            content()
        }
        .padding([.bottom, .horizontal], ViewValues.Padding.medium)
    }
}
