//
//  GoalSection.swift
//  CHECKIT
//
//  Created by phang on 1/30/25.
//

import SwiftUI

struct GoalSection<Content: View>: View {
    private let title: String
    private let isRequired: Bool
    private let description: String?
    private let content: () -> Content
    
    init(
        title: String,
        isRequired: Bool,
        description: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.isRequired = isRequired
        self.description = description
        self.content = content
    }
    
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
