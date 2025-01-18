//
//  Goal.swift
//  CHECKIT
//
//  Created by phang on 1/16/25.
//

import Foundation

struct Goal: Identifiable {
    let id: UUID
    var title: String               // 목표 이름
    var activeDays: Set<Weekday>    // 실행할 요일
    var notificationEnabled: Bool   // 알림 활성화 여부
    var notificationTime: Int?      // 알림을 받을 시간
    var isActive: Bool              // 목표 실행 여부
    var streakCount: Int            // 현재 연속 달성 일수
}
