//
//  SchemePicker.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI

struct SchemePicker: View {
    @EnvironmentObject private var themeManager: ThemeManager
    //
    @Binding private var previews: [SchemePreview]
    
    init(
        previews: Binding<[SchemePreview]>
    ) {
        self._previews = previews
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewValues.Padding.medium) {
            // Header
            Text("다크 모드 / 라이트 모드")
                .font(.system(size: 18)) // TODO: font 수정 예정
                .fontWeight(.medium)
                .foregroundStyle(.budBlack)
            //
            Spacer(minLength: ViewValues.Padding.zero)
            // Picker
            GeometryReader { _ in
                HStack(spacing: 0) {
                    // 다크, 라이트
                    ForEach(previews) { preview in
                        SchemeCardView(
                            previews: [preview],
                            schemeType: preview.text == AppScheme.dark.rawValue ? .dark : .light
                        )
                    }
                    // 사용자 기기
                    SchemeCardView(
                        previews: previews,
                        schemeType: .device
                    )
                }
            }
        }
        .padding(ViewValues.Padding.default)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background {
            ZStack {
                Rectangle()
                    .fill(.background)
                Rectangle()
                    .fill(.budBlack.opacity(ViewValues.Opacity.light))
            }
            .clipShape(.rect(cornerRadius: ViewValues.Radius.default))
        }
        .padding(.horizontal, ViewValues.Padding.default)
        .presentationDetents([.height(ViewValues.Size.timePickerViewHeight)])
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    fileprivate func SchemeCardView(
        previews: [SchemePreview],
        schemeType: AppScheme
    ) -> some View {
        VStack(spacing: 6) {
            //
            if let image = previews.first?.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        if schemeType == .device,
                           let secondImage = previews.last?.image {
                            GeometryReader { geo in
                                Image(uiImage: secondImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .mask(alignment: .trailing) {
                                        Rectangle()
                                            .frame(width: geo.size.width / 2)
                                    }
                            }
                        }
                    }
                    .clipShape(.rect(cornerRadius: 15))
            }
            // 설명 텍스트 값 할당
            let text = schemeType == .device ? AppScheme.device.rawValue : previews.first?.text ?? ""
            // 텍스트
            Text(text)
                .font(.system(size: 13)) // TODO: font 수정 예정
                .fontWeight(.regular)
                .foregroundStyle(.midGray)
            // 체크 마크
            ZStack {
                if themeManager.currentScheme.rawValue == text {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.budBlack)
                        .transition(.blurReplace)
                }
                Image(systemName: "circle")
                    .foregroundStyle(.budBlack)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(.rect)
        .onTapGesture {
            if schemeType == .device {
                themeManager.updateAppearance(to: schemeType)
            } else {
                let schemeType = previews.first?.text == AppScheme.dark.rawValue ? AppScheme.dark : AppScheme.light
                themeManager.updateAppearance(to: schemeType)
            }
        }
    }
}
