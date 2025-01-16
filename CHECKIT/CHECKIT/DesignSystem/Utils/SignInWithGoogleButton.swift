//
//  SignInWithGoogleButton.swift
//  CHECKIT
//
//  Created by phang on 1/15/25.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    // For managing button animation
    @State private var isPressed = false
    
    private let action: () -> Void
    
    init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack(alignment: .center) {
                // BG
                RoundedRectangle(cornerRadius: ViewValues.Radius.medium)
                    .fill(.white) // 디스플레이모드와 상관없이 white 유지
                    .strokeBorder(.cellLevel1, lineWidth: ViewValues.Size.lineWidth)
                    .overlay {
                        RoundedRectangle(cornerRadius: ViewValues.Radius.medium)
                            .fill(isPressed ? .budBlack.opacity(ViewValues.Opacity.level2) : .clear)
                    }
                    .frame(width: ViewValues.Size.loginButtonWidth,
                           height: ViewValues.Size.loginButtonHeight)
                // Label
                HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
                    Image("GoogleLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ViewValues.Size.loginLogoSize)
                    Text("Google로 로그인")
                        .font(.system(size: 18)) // TODO: font 설정 필요
                        .fontWeight(.medium)
                        .foregroundStyle(.midGray)
                }
            }
        }
        .buttonStyle(PressButtonStyle(isPressed: $isPressed))
    }
}
