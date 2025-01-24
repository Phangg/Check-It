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
    @State private var showInvalidWebViewMessage = false
    
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
                                if item == .notification {
                                    SettingListItemCell(
                                        isOnNotification: $isOnNotification,
                                        item: item
                                    )
                                } else {
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
                isPresented: $showWebViewSheet,
                onDismiss: {
                    selectedWebViewURL = nil
                    showInvalidWebViewMessage = false
                },
                content: {
                    if let url = selectedWebViewURL, url.isValid() {
                        WebView(url: url)
                    } else if showInvalidWebViewMessage {
                        // 10초 후 잘못된 페이지 메시지
                        VStack(alignment: .center, spacing: ViewValues.Padding.large) {
                            Group {
                                //
                                Text("403 Forbidden")
                                //
                                Text("페이지를 찾을 수 없음")
                            }
                            .font(.system(size: 20)) // TODO: font 수정 예정
                            .fontWeight(.bold)
                            .foregroundStyle(.budBlack)
                        }
                    } else {
                        ProgressView()
                            .scaleEffect(ViewValues.Scale.big)
                            .tint(.budBlack)
                            .onAppear {
                                // 10초 후에 잘못된 페이지 메시지 표시
                                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                    showInvalidWebViewMessage = true
                                }
                            }
                    }
                }
            )
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
            if let url = item.url {
                selectedWebViewURL = url
                showWebViewSheet = true
            }
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
}
