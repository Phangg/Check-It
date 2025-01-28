//
//  Loginview.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

import SwiftUI
import AuthenticationServices

struct Loginview: View {
    @Environment(\.openURL) private var openURL
    //
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @State private var showWebViewSheet: Bool = false
    @State private var errorMessage: String = ""
    @State private var showErrorAlert: Bool = false
    
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
                    RequestButton(.privacyPolicy)
                    RequestButton(.request)
                }
            }
        }
        .padding(ViewValues.Padding.default)
        // 개인정보 처리 방침 - WebView 시트
        .sheet(
            isPresented: $showWebViewSheet,
            onDismiss: {
                if !errorMessage.isEmpty {
                    showErrorAlert = true
                }
            },
            content: {
                WebView(
                    url: SettingItem.privacyPolicy.url!, // openPrivacyPolicyWebView() 에서 검증
                    errorMessage: $errorMessage,
                    showWebViewSheet: $showWebViewSheet
                )
            }
        )
        // WebView 에러 alert
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("개인정보 처리 방침 페이지 로드 오류"),
                message: Text(errorMessage),
                dismissButton: .default(Text("확인")) { errorMessage = "" }
            )
        }
    }
    
    @ViewBuilder
    fileprivate func RequestButton(_ item: SettingItem) -> some View {
        let text = item == .request ? "로그인에 문제가 있어요" : item.title
        //
        HStack(alignment: .center, spacing: ViewValues.Padding.medium) {
            //
            GrowCell(
                type: .small,
                backgroundColor: appMainColorManager.appMainColor.mainColor.opacity(ViewValues.Opacity.level3)
            )
            //
            Button {
                handleTapAction(item)
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
    
    private func handleTapAction(_ item: SettingItem) {
        switch item {
        case .privacyPolicy:
            openPrivacyPolicyWebView(url: item.url)
        case .request:
            openEmailApp()
        default:
            break
        }
    }
    
    private func openPrivacyPolicyWebView(url: URL?) {
        guard let url = url, url.isValid() else {
            errorMessage = "잘못된 URL 입니다."
            showErrorAlert = true
            return
        }
        showWebViewSheet = true
    }
    
    private func openEmailApp() {
        let supportEmail = SupportEmail(toAddress: "a@a.com") // TODO: 이메일 주소 config 에 저장 및 수정 예정
        supportEmail.send(openURL: openURL)
    }
}
