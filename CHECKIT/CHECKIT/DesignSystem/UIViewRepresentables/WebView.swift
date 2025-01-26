//
//  WebView.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding private var errorMessage: String
    @Binding private var showWebViewSheet: Bool
    //
    private let url: URL

    init(
        url: URL,
        errorMessage: Binding<String>,
        showWebViewSheet: Binding<Bool>
    ) {
        self.url = url
        self._errorMessage = errorMessage
        self._showWebViewSheet = showWebViewSheet
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webview.load(request)
        webview.allowsBackForwardNavigationGestures = true
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 새로운 로딩 시작 시 상태 초기화
            parent.errorMessage = ""
        }
        
        // 웹뷰가 콘텐츠 데이터를 받아오는 것을 모두 마쳤을 때 호출
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.errorMessage = ""
        }
        
        // 초기 로딩 에러
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.errorMessage = error.localizedDescription
            parent.showWebViewSheet = false
        }
        
        // 초기 로딩 이후 에러
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.errorMessage = error.localizedDescription
            parent.showWebViewSheet = false
        }
    }
}
