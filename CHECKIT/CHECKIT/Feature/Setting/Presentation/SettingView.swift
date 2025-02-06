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
    @StateObject private var container: MVIContainer<SettingIntent, SettingModelState>
    private var intent: SettingIntent { container.intent }
    private var state: SettingModelState { container.model }
    
    init() {
        let model = SettingModelImp()
        let intent = SettingIntentImp(
            model: model
        )
        let container = MVIContainer(
            intent: intent as SettingIntent,
            model: model as SettingModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
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
                                    isOnNotification: Binding(
                                        get: { state.isOnNotification },
                                        set: { intent.update(isOnNotification: $0) }
                                    ),
                                    item: item
                                )
                            case .appVersion:
                                SettingListItemCell(item: item)
                            default:
                                Button {
                                    self.handleTapAction(item)
                                } label: {
                                    SettingListItemCell(item: item)
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
                intent.handleOnAppear()
            }
            // 앱 색상 변경 - ColorPicker 시트
            .sheet(
                isPresented: Binding(
                    get: { state.showColorPicker},
                    set: { intent.update(showColorPicker: $0) }
                ),
                content: {
                    CustomColorPicker(
                        appMainColor: appMainColorManager.appMainColor,
                        showColorPicker: Binding(
                            get: { state.showColorPicker},
                            set: { intent.update(showColorPicker: $0) }
                        )
                    )
                }
            )
            // 디스플레이 변경 - SchemePicker 시트
            .sheet(
                isPresented: Binding(
                    get: { state.showSchemePicker},
                    set: { intent.update(showSchemePicker: $0) }
                ),
                onDismiss: {
                    intent.update(schemePreviews: [])
                },
                content: {
                    SchemePicker(
                        previews: Binding(
                            get: { state.schemePreviews},
                            set: { intent.update(schemePreviews: $0) }
                        )
                    )
                }
            )
            // 개인정보 처리 방침 & 이용 약관 - WebView 시트
            .sheet(
                isPresented: Binding(
                    get: { state.showWebViewSheet && state.selectedWebViewURL != nil },
                    set: { intent.update(showWebViewSheet: $0) }
                ),
                onDismiss: {
                    // TODO: -
                    intent.update(selectedWebViewURL: nil)
                    if !state.errorMessage.isEmpty {
                        intent.update(showErrorAlert: true)
                    }
                },
                content: {
                    WebView(
                        url: state.selectedWebViewURL!, // openWebView() 에서 검증
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
            // 에러 alert
            .alert(
                isPresented: Binding(
                    get: { state.showErrorAlert },
                    set: { intent.update(showErrorAlert: $0) }
                )
            ) {
                Alert(
                    title: Text("페이지 로드 오류"),
                    message: Text(state.errorMessage),
                    dismissButton: .default(Text("확인")) { intent.update(errorMessage: "") }
                )
            }
        }
    }
    
    @ToolbarContentBuilder
    private func SettingViewToolbarContent() -> some ToolbarContent {
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
    
    private func handleTapAction(_ item: SettingItem) {
        switch item {
        case .notification:
            break
        case .appMainColor:
            intent.update(showColorPicker: true)
        case .displayMode:
            intent.handleTapDisplayMode()
        case .privacyPolicy, .termsAndConditions:
            intent.validateAndPresentWebView(url: item.url)
        case .appEvaluation:
            intent.validateURLOrShowAlert(url: item.url).map { openURL($0) } // @Environment(\.openURL)
        case .request:
            // TODO: 이메일 주소 config 에 저장 및 수정 예정
            SupportEmail().send(openURL: openURL) // @Environment(\.openURL)
        case .logout:
            print("logout") // TODO: 수정 예정
        case .cancelAccount:
            print("cancelAccount") // TODO: 수정 예정
        case .appVersion:
            break
        }
    }
}
