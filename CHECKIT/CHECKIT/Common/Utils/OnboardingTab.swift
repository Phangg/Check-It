//
//  OnboardingTab.swift
//  CHECKIT
//
//  Created by phang on 1/14/25.
//

// TODO: page1,2,3 가 아닌 각각의 온보딩 페이지에 맞는 이름으로 수정 예정
enum OnboardingTab: Int, Hashable, CaseIterable {
    case page1
    case page2
    case page3
    
    var title: String {
        switch self {
        case .page1:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        case .page2:
            "Where does it come from?"
        case .page3:
            "Where can I get some?"
        }
    }
    
    var description: String {
        switch self {
        case .page1:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        case .page2:
            "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."
        case .page3:
            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."
        }
    }
    
    var nextButtonText: String {
        switch self {
        case .page1, .page2:
            "Continue"
        case .page3:
            "Login / Sign up"
        }
    }
}
