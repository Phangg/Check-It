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
    @EnvironmentObject private var themeManager: ThemeManager
    //
    @StateObject private var container: MVIContainer<LoginIntent, LoginModelState>
    private var intent: LoginIntent { container.intent }
    private var state: LoginModelState { container.model }
    
    init() {
        let model = LoginModelImp()
        let intent = LoginIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as LoginIntent,
            model: model as LoginModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
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
                    .signInWithAppleButtonStyle(
                        themeManager.currentScheme == .light ?
                            .black : themeManager.currentScheme == .dark ?
                            .white: ThemeManager.currentSystemInterfaceStyle == .light ? .black : .white
                    )
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
            isPresented: Binding(
                get: { state.showWebViewSheet },
                set: { intent.update(showWebViewSheet: $0) }
            ),
            onDismiss: {
                intent.dismissWebView(isErrorMessageEmpty: state.errorMessage.isEmpty)
            },
            content: {
                WebView(
                    url: SettingItem.privacyPolicy.url!, // openPrivacyPolicyWebView() 에서 검증
                    errorMessage: Binding(
                        get: { state.errorMessage },
                        set: { intent.update(errorMessage: $0) }
                    ),
                    showWebViewSheet: Binding(
                        get: { state.showWebViewSheet },
                        set: { intent.update(showWebViewSheet: $0) }
                    )
                )
            }
        )
        // WebView 에러 alert
        .alert(
            isPresented: Binding(
                get: { state.showErrorAlert },
                set: { intent.update(showErrorAlert: $0) }
            )
        ) {
            Alert(
                title: Text("개인정보 처리 방침 페이지 로드 오류"),
                message: Text(state.errorMessage),
                dismissButton: .default(Text("확인")) { intent.update(errorMessage: "") }
            )
        }
    }
    
    @ViewBuilder
    private func RequestButton(_ item: SettingItem) -> some View {
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
                self.handleTapAction(item)
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
            intent.openPrivacyPolicyWebView(url: item.url)
        case .request:
            // TODO: 이메일 주소 config 에 저장 및 수정 예정
            SupportEmail().send(openURL: openURL) // @Environment(\.openURL)
        default:
            break
        }
    }
}
