//
//  SettingItem.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

enum SettingItem: String, CaseIterable {
    case notification = "알림 설정"
    case appMainColor = "앱 색상 설정"
    case displayMode = "화면 모드 설정"
    case privacyPolicy = "개인정보 처리 방침"
    case termsAndConditions = "이용 약관"
    case appEvaluation = "앱 평가"
    case request = "문의 및 요청"
    case logout = "로그아웃"
    case cancelAccount = "회원탈퇴"
    
    var title: String { self.rawValue }
    
    var subtitle: String? {
        switch self {
        case .notification:
            "목표마다 설정된 시간에 알림을 받을 수 있어요"
        case .appMainColor:
            "앱의 메인 색상을 변경할 수 있어요"
        case .displayMode:
            "다크 모드 / 라이트 모드"
        case .appEvaluation:
            "앱스토어에서 평가해 주세요"
        case .request:
            "앱에 대한 문의나 요청을 보내주세요"
        case .privacyPolicy, .termsAndConditions, .logout, .cancelAccount:
            nil
        }
    }
    
    var image: String {
        switch self {
        case .notification:
            "bell.fill"
        case .appMainColor:
            "paintbrush.fill"
        case .displayMode:
            "circle.lefthalf.filled"
        case .privacyPolicy:
            "lock.fill"
        case .termsAndConditions:
            "text.document.fill"
        case .appEvaluation:
            "apps.iphone"
        case .request:
            "envelope.fill"
        case .logout:
            "figure.walk"
        case .cancelAccount:
            "trash.fill"
        }
    }
}
