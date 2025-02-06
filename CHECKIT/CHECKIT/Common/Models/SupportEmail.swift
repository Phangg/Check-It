//
//  SupportEmail.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI

struct SupportEmail {
    let toAddress: String = ServiceConfiguration.supportEmail   // 개발자 이메일 주소
    let subject: String = "Check-It : 문의 및 요청"                // 제목
    var body: String = """
        안녕하세요,

        'Check-It' 에 대한 문의나 요청 사항이 있으시면, 아래의 정보를 포함하여 이메일을 보내주세요 :)

        1. 발생한 문제나 요청 사항에 대한 상세한 설명
        2. 문제가 발생한 시점과 환경 (예: iOS 버전, 앱 버전 등)
        3. 화면 캡처나 관련 파일 (가능한 경우 첨부)

        가능한 한 빠르게 처리해 드리겠습니다. 감사합니다.
    """
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("ERROR: SupportEmail - send")
                fatalError("SupportEmail - send")
            }
        }
    }
}
