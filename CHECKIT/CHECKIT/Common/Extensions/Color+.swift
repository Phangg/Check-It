//
//  Color+.swift
//  CHECKIT
//
//  Created by phang on 1/24/25.
//

import SwiftUI

// rawValue 정의
/// Base64 인코딩된 데이터를 UIColor로 디코딩
/// 실패 시 기본적으로 .accentColor 사용
extension Color: @retroactive RawRepresentable {
    public init?(
        rawValue: String
    ) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .accent
            return
        }
        
        do {
            if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
                self = Color(color)
            } else {
                self = .accent
            }
        } catch {
            self = .accent
        }
    }
    
    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}

//
extension Color {
   // 색의 특정 속성들을 조정하는 메서드
   func adjust(
       hue: CGFloat = 0,         // 색조 변경 (-1 ~ 1 사이)
       saturation: CGFloat = 0,  // 채도 변경 (-1 ~ 1 사이)
       brightness: CGFloat = 0,  // 밝기 변경 (-1 ~ 1 사이)
       opacity: CGFloat = 1      // 불투명도 변경 (0 ~ 1 사이)
   ) -> Color {
       // 현재 색을 UIColor로 변환
       let color = UIColor(self)
       // 현재 색의 속성을 저장할 변수들
       var currentHue: CGFloat = 0
       var currentSaturation: CGFloat = 0
       var currentBrigthness: CGFloat = 0
       var currentOpacity: CGFloat = 0
       // 색 속성 추출 성공 시
       if color.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentOpacity) {
           // 새로운 색 생성 및 반환 (기존 값에 입력된 값 더하기)
           return Color(hue: currentHue + hue,
                        saturation: currentSaturation + saturation,
                        brightness: currentBrigthness + brightness,
                        opacity: currentOpacity + opacity)
       }
       // 색 추출 실패 시 기존 색 반환
       return self
   }
}
