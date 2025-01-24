//
//  Loginview.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import SwiftUI
import AuthenticationServices

struct Loginview: View {
    var body: some View {
        VStack(alignment: .center, spacing: ViewValues.Padding.huge) {
            // Logo
            AppNameLogo()
                .padding(.top, ViewValues.Padding.huge)
            VStack(alignment: .center) {
                // Buttons
                VStack(spacing: ViewValues.Padding.default) {
                    // Apple
                    SignInWithAppleButton( // TODO: 임시 버튼
                        onRequest: { _ in },
                        onCompletion: { _ in }
                    )
                    .signInWithAppleButtonStyle(.black) // TODO: 디스플레이모드에 따라 수정 필요
                    .frame(width: ViewValues.Size.loginButtonWidth,
                           height: ViewValues.Size.loginButtonHeight)
                    .clipShape(.rect(cornerRadius: ViewValues.Radius.medium))
                    // Google
                    SignInWithGoogleButton { }  // TODO: 임시 버튼
                }
                //
                Spacer(minLength: ViewValues.Padding.default)
                // Info & Request
                VStack(alignment: .leading, spacing: ViewValues.Padding.medium) {
                    RequestButton(type: .privacyPolicy)
                    RequestButton(type: .request)
                }
            }
        }
        .padding(ViewValues.Padding.default)
    }
    
    @ViewBuilder
    fileprivate func RequestButton(type: SettingItem) -> some View {
        let text = type == .request ? "로그인에 문제가 있어요" : type.title
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            //
            GrowCell(
                type: .small,
                backgroundColor: .accent.opacity(ViewValues.Opacity.level3) // TODO: color 수정 필요
            )
            //
            Button {
                // TODO: - 버튼에 맞는 웹으로 이동
            } label: {
                Text(text)
                    .font(.system(size: 13)) // TODO: font 수정 필요
                    .fontWeight(.light)
                    .foregroundStyle(.budBlack)
                    .underline(color: .budBlack)
            }
            .buttonStyle(.plain)
        }
    }
}
