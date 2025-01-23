//
//  WebView.swift
//  CHECKIT
//
//  Created by phang on 1/22/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        //
    }
}
