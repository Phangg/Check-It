//
//  TextBox.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import SwiftUI

struct TextBox: View {
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    
    init(
        text: Binding<String>
    ) {
        self._text = text
    }
    
    var body: some View {
        ZStack {
            // BG
            RoundedRectangle(cornerRadius: ViewValues.Radius.small)
                .fill(.neutralGray)
                .frame(maxWidth: .infinity)
                .frame(height: ViewValues.Size.settingItemHeight)
            //
            HStack {
                // Text
                TextField(
                    "목표 설정하기",
                    text: $text,
                    prompt: Text("예) 운동하기, 독서하기 등") // TODO: 폰트 설정 필요
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(.midGray)
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .lineLimit(1)
                .submitLabel(.done)
                .focused($isFocused)
                // Clear Button
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.midGray)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, ViewValues.Padding.medium)
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: ViewValues.Padding.default) {
        TextBox(text: .constant(""))
        TextBox(text: .constant("30분 러닝하기"))
    }
    .padding(ViewValues.Padding.default)
}
