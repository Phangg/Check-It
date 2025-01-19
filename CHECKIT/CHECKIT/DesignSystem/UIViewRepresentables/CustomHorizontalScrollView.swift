//
//  CustomHorizontalScrollView.swift
//  CHECKIT
//
//  Created by phang on 1/18/25.
//

import SwiftUI

// ScrollView 와 ScrollView 내부의 버튼의 제스처 충돌로 인해 UIKit 사용
struct CustomHorizontalScrollView<Content: View>: UIViewRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delaysContentTouches = false // 터치 지연 비활성화
        scrollView.alwaysBounceVertical = true // 스크롤 활성화
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostedView)
        
        NSLayoutConstraint.activate([
            hostedView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostedView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostedView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostedView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = content
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var hostingController: UIHostingController<Content>
        
        init(_ parent: CustomHorizontalScrollView) {
            hostingController = UIHostingController(rootView: parent.content)
            hostingController.view.backgroundColor = .clear
        }
    }
}
