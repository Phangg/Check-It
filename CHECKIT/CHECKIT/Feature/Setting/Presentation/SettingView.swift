//
//  SettingView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    //
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @State private var isOnNotification: Bool = false
    @State private var showSchemePicker: Bool = false
    @State private var schemePreviews: [SchemePreview] = []
    @State private var overlayWindow: UIWindow? = nil
    @State private var showColorPicker: Bool = false
    @State private var selectedWebViewURL: URL? = nil
    @State private var showWebViewSheet: Bool = false
    @State private var errorMessage: String = ""
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            //
            ScrollView(.vertical) {
                // Settings
                LazyVStack(alignment: .leading, spacing: ViewValues.Padding.default) {
                    ForEach(SettingSection.allCases, id: \.self) { section in
                        // Section
                        Text(section.rawValue)
                            .font(.system(size: 16)) // TODO: font 수정 예정
                            .fontWeight(.medium)
                            .foregroundStyle(.budBlack)
                            .frame(
                                height: ViewValues.Size.settingSectionHeight,
                                alignment: .center
                            )
                        // Items
                        ForEach(section.items, id: \.self) { item in
                            switch item {
                            case .notification:
                                SettingListItemCell(
                                    isOnNotification: $isOnNotification,
                                    item: item
                                )
                            case .appVersion:
                                SettingListItemCell(
                                    isOnNotification: nil,
                                    item: item
                                )
                            default:
                                Button {
                                    handleTapAction(item)
                                } label: {
                                    SettingListItemCell(
                                        isOnNotification: nil,
                                        item: item
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                            // Divider - Item
                            if item != section.items.last! {
                                CustomDivider()
                                    .padding(.trailing, -ViewValues.Padding.default)
                            }
                        }
                        // Divider - Section
                        if section != .account {
                            CustomDivider(
                                color: .softGray,
                                type: .horizontal(height: ViewValues.Padding.medium)
                            )
                            .padding(.horizontal, -ViewValues.Padding.default)
                        }
                    }
                }
                .padding(.horizontal, ViewValues.Padding.default)
                .padding(.bottom, ViewValues.Padding.big)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { SettingViewToolbarContent() }
            .onAppear {
                // 앱 스키마 스크린샷을 위한 준비
                prepareOverlayWindow()
            }
            // 앱 색상 변경 - ColorPicker 시트
            .sheet(
                isPresented: $showColorPicker,
                content: {
                    CustomColorPicker(
                        appMainColor: appMainColorManager.appMainColor,
                        showColorPicker: $showColorPicker
                    )
                }
            )
            // 디스플레이 변경 - SchemePicker 시트
            .sheet(
                isPresented: $showSchemePicker,
                onDismiss: {
                    schemePreviews = []
                },
                content: {
                    SchemePicker(previews: $schemePreviews)
                }
            )
            // 개인정보 처리 방침 & 이용 약관 - WebView 시트
            .sheet(
                isPresented: .init(
                    get: { showWebViewSheet && selectedWebViewURL != nil },
                    set: { showWebViewSheet = $0 }
                ),
                onDismiss: {
                    selectedWebViewURL = nil
                    if !errorMessage.isEmpty {
                        showErrorAlert = true
                    }
                },
                content: {
                    WebView(
                        url: selectedWebViewURL!, // openWebView() 에서 검증
                        errorMessage: $errorMessage,
                        showWebViewSheet: $showWebViewSheet
                    )
                }
            )
            // 에러 alert
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("페이지 로드 오류"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("확인")) { errorMessage = "" }
                )
            }
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
    
    fileprivate func handleTapAction(_ item: SettingItem) {
        switch item {
        case .notification:
            break
        case .appMainColor:
            showColorPicker = true
        case .displayMode:
            generateSchemePreviews(currentScheme: ThemeManager.currentSystemInterfaceStyle)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showSchemePicker = true
            }
        case .privacyPolicy, .termsAndConditions:
            openWebView(url: item.url)
        case .appEvaluation:
            if let url = item.url {
                openURL(url)
            }
        case .request:
            let supportEmail = SupportEmail(toAddress: "a@a.com") // TODO: 이메일 주소 config 에 저장 및 수정 예정
            supportEmail.send(openURL: openURL)
        case .logout:
            print("logout") // TODO: 수정 예정
        case .cancelAccount:
            print("cancelAccount") // TODO: 수정 예정
        case .appVersion:
            break
        }
    }
    
    @MainActor
    fileprivate func generateSchemePreviews(currentScheme: UIUserInterfaceStyle) {
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow,
               schemePreviews.isEmpty {
                let size = window.screen.bounds.size
                let defaultStyle = window.overrideUserInterfaceStyle
                // 현재 스키마 이미지
                let defautSchemePreview = window.image(size)
                schemePreviews.append(
                    .init(
                        image: defautSchemePreview,
                        text: currentScheme == .dark ? AppScheme.dark.rawValue : AppScheme.light.rawValue
                    )
                )
                // overlayWindow 에 이미지 표시
                showOverlayImageView(defautSchemePreview)
                // 반대 스키마로 변경
                window.overrideUserInterfaceStyle = currentScheme.oppsiteInterfaceStyle
                // 반대 스키마 이미지
                let otherSchemePreviewImage = window.image(size)
                schemePreviews.append(
                    .init(
                        image: otherSchemePreviewImage,
                        text: currentScheme == .dark ? AppScheme.light.rawValue : AppScheme.dark.rawValue
                    )
                )
                // 다크모드의 경우 순서 바꾸기
                if currentScheme == .dark {
                    schemePreviews = schemePreviews.reversed()
                }
                // 스키마 복구
                window.overrideUserInterfaceStyle = defaultStyle
                try? await Task.sleep(for: .seconds(0))
                // overlayWindow 에 이미지 제거
                removeOverlayImageView()
            }
        }
    }
    
    fileprivate func showOverlayImageView(_ image: UIImage?) {
        removeOverlayImageView()
        //
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            overlayWindow?.rootViewController?.view.addSubview(imageView)
        }
    }
    
    fileprivate func removeOverlayImageView() {
        overlayWindow?.rootViewController?.view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    fileprivate func prepareOverlayWindow() {
        if let scene = (UIApplication.shared.connectedScenes.first as? UIWindowScene),
           overlayWindow == nil {
            let window = UIWindow(windowScene: scene)
            window.backgroundColor = .clear
            window.isHidden = false
            window.isUserInteractionEnabled = false
            let emptyController = UIViewController()
            emptyController.view.backgroundColor = .clear
            window.rootViewController = emptyController
            overlayWindow = window
        }
    }
    
    private func openWebView(url: URL?) {
        guard let url = url, url.isValid() else {
            errorMessage = "잘못된 URL 입니다."
            showErrorAlert = true
            return
        }
        selectedWebViewURL = url
        showWebViewSheet = true
    }
}
