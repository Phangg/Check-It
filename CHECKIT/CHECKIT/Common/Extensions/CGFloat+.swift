//
//  CGFloat+.swift
//  CHECKIT
//
//  Created by phang on 1/24/25.
//

import Foundation

extension CGFloat {
    // 한 범위의 값을 다른 범위로 선형적으로 매핑하는 메서드
    func map(from inputRange: ClosedRange<CGFloat>, to outputRange: ClosedRange<CGFloat>) -> CGFloat {
        // 입력 범위가 유효하지 않은 경우 (0으로 나누는 것 방지)
        guard inputRange.lowerBound != inputRange.upperBound else {
            // 입력 범위가 0인 경우 출력 범위의 하한값 반환
            return outputRange.lowerBound
        }
        // 입력 값을 0-1 사이로 정규화
        let normalizedValue = (self - inputRange.lowerBound) / (inputRange.upperBound - inputRange.lowerBound)
        // 정규화된 값을 대상 범위로 매핑
        return normalizedValue * (outputRange.upperBound - outputRange.lowerBound) + outputRange.lowerBound
    }
}
