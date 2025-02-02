//
//  SplashIntentImp.swift
//  CHECKIT
//
//  Created by phang on 2/2/25.
//

import Foundation

final class SplashIntentImp {
    // Model
    private weak var model: SplashModelAction?
    //
    private let onFetchComplete: () -> Void
    
    init(
        model: SplashModelAction,
        onFetchComplete: @escaping () -> Void
    ) {
        self.model = model
        self.onFetchComplete = onFetchComplete
    }
    
    private func waitForAnimationEnd(duration: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
    }
}

// MARK: - Intent
extension SplashIntentImp: SplashIntent {
    @MainActor 
    func handleOnAppear() {
        Task { // TODO: 데이터 받아오는 역할로 수정 예정
            // 애니메이션 시작 전 잠시 대기
            await waitForAnimationEnd(duration: ViewValues.Duration.regular)
            //
            model?.update(animationActive: true)
            // 애니메이션
            await waitForAnimationEnd(duration: ViewValues.Duration.long)
            // 애니메이션 종료 후 잠시 대기
            await waitForAnimationEnd(duration: ViewValues.Duration.regular)
            //
            onFetchComplete()
        }
    }
}
