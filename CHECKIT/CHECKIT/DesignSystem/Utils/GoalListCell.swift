//
//  GoalListCell.swift
//  CHECKIT
//
//  Created by phang on 1/11/25.
//

import SwiftUI

struct GoalListCell: View {
    // For managing button animation
    @State private var isPressed = false
    // Check whether the goal has been completed or not
    @Binding private var isCompleted: Bool
    @Binding private var goalStreakCount: Int
    
    private let title: String
    private let action: () -> Void
    
    init(
        isCompleted: Binding<Bool>,
        goalStreakCount: Binding<Int>,
        title: String,
        action: @escaping () -> Void
    ) {
        self._isCompleted = isCompleted
        self._goalStreakCount = goalStreakCount
        self.title = title
        self.action = action
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // BG
            RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                .fill(isCompleted ? .budWhite : .softGray)
                .strokeBorder(isCompleted ? .cellLevel1 : .clear, lineWidth: ViewValues.Size.lineWidth)
                .overlay {
                    RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                        .fill(isPressed ? .budBlack.opacity(ViewValues.Opacity.light) : .clear)
                }
                .frame(height: ViewValues.Size.goalCellHeight)
                .scaleEffect(isPressed ? ViewValues.Scale.pressed : ViewValues.Scale.default)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            withAnimation(.easeInOut(duration: ViewValues.Duration.regular)) {
                                isPressed = true
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.easeInOut(duration: ViewValues.Duration.regular)) {
                                isPressed = false
                                isCompleted.toggle()
                                action()
                            }
                        }
                )
            // Contents
            HStack(alignment: .center) {
                // Cell Box & Title
                HStack(spacing: ViewValues.Padding.default) {
                    // Cell Box
                    GrowCell(backgroundColor: isCompleted ? .blue : .cellLevel1) // TODO: color 수정 필요
                    // Title
                    Text(title)
                        .lineLimit(2)
                        .foregroundStyle(isCompleted ? .midGray : .budBlack)
                        // TODO: - 버튼 폰트 설정 필요
                        .animatedStrikethrough(isActive: isCompleted, color: .midGray)

                }
                //
                Spacer(minLength: ViewValues.Padding.default)
                // Streak
                if goalStreakCount > 0 {
                    VStack(alignment: .center, spacing: ViewValues.Padding.tiny) {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: ViewValues.Size.streakImageHeight)
                            .foregroundStyle(.red) // TODO: color 수정 필요
                        Text("\(goalStreakCount)")
                            .foregroundStyle(.midGray)
                            .font(.footnote) // TODO: - 버튼 폰트 설정 필요
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: ViewValues.Duration.long), value: goalStreakCount)
                }
            }
            .scaleEffect(isPressed ? ViewValues.Scale.pressed : ViewValues.Scale.default)
            .padding(ViewValues.Padding.default)
        }
    }
}

// MARK: - 미리보기 테스트 용
fileprivate struct GoalListCellPreview: View {
    @State private var isCompleted = false
    @State private var goalStreakCount = 0

    var body: some View {
        VStack {
            GoalListCell(
                isCompleted: $isCompleted,
                goalStreakCount: $goalStreakCount,
                title: "30분 러닝하기"
            ) {
                if isCompleted {
                    goalStreakCount += 1
                } else {
                    goalStreakCount -= 1
                }
            }
        }
        .padding(ViewValues.Padding.default)
    }
}

#Preview {
    GoalListCellPreview()
}
