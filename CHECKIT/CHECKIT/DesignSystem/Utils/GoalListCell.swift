//
//  GoalListCell.swift
//  CHECKIT
//
//  Created by phang on 1/11/25.
//

import SwiftUI

struct GoalListCell: View {
    @EnvironmentObject private var swipedCellManager: SwipedCellManager
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    // For managing button animation
    @State private var isPressed = false
    // Check whether the goal has been completed or not
    @Binding private var isCompleted: Bool
    @Binding private var goalStreakCount: Int
    //
    @State private var dragOffset: CGSize = .zero
    @State private var currentPosition: CGSize = .zero
    @State private var targetPosition: CGSize = .zero
    
    private let cellID: UUID
    private let title: String
    private let action: () -> Void
    private let editAction: () -> Void
    private let deleteAction: () -> Void
    
    init(
        isCompleted: Binding<Bool>,
        goalStreakCount: Binding<Int>,
        cellID: UUID,
        title: String,
        action: @escaping () -> Void,
        editAction: @escaping () -> Void,
        deleteAction: @escaping () -> Void
    ) {
        self._isCompleted = isCompleted
        self._goalStreakCount = goalStreakCount
        self.cellID = cellID
        self.title = title
        self.action = action
        self.editAction = editAction
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        Button {
            if currentPosition.width == 0 { // 스와이프 중 버튼 비활성화
                isCompleted.toggle()
                action()
            }
        } label: {
            ZStack(alignment: .center) {
                // BG
                RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                    .fill(isCompleted ? .budWhite : .neutralGray)
                    .strokeBorder(isCompleted ? .cellLevel1 : .clear, lineWidth: ViewValues.Size.lineWidth)
                    .overlay {
                        RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                            .fill(isPressed ? .budBlack.opacity(ViewValues.Opacity.light) : .clear)
                    }
                    .frame(height: ViewValues.Size.goalCellHeight)
                // Contents
                HStack(alignment: .center) {
                    // Cell Box & Title
                    HStack(spacing: ViewValues.Padding.default) {
                        // Cell Box
                        GrowCell(backgroundColor: isCompleted ? appMainColorManager.appMainColor.mainColor : .cellLevel1)
                            .overlay(alignment: .center) {
                                Image(systemName: "checkmark")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(isCompleted ? .budWhite : .clear)
                            }
                        // Title
                        Text(title)
                            .lineLimit(1)
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
                        .animation(.easeInOut(duration: ViewValues.Duration.regular), value: goalStreakCount)
                    }
                }
                .padding(.horizontal, ViewValues.Padding.default)
            }
        }
        .id(cellID)
        .disabled(swipedCellManager.currentlySwipedCellID != nil) // 스와이프 중 버튼 비활성화
        .buttonStyle(PressButtonStyle(isPressed: $isPressed))
        .hapticOnTap(
            type: .impact(feedbackStyle: .light),
            isActive: swipedCellManager.currentlySwipedCellID == nil
        )
        // 드래그해서 수정 및 삭제 버튼 보기
        .offset(x: dragOffset.width + currentPosition.width)
        .animation(.linear(duration: ViewValues.Duration.short), value: [dragOffset, currentPosition])
        .simultaneousGesture(
            DragGesture(minimumDistance: 20)
                .onChanged { value in
                    // 왼쪽으로 드래그할 때만 || 열려있는 상태에서만
                    if value.translation.width <= 0 || currentPosition.width < 0 {
                        if swipedCellManager.currentlySwipedCellID != cellID {
                            swipedCellManager.setCellSwiped(cellID)
                        }
                        dragOffset = value.translation
                        targetPosition.width = dragOffset.width + currentPosition.width
                    }
                }
                .onEnded { value in
                    if dragOffset.width < -40 {
                        currentPosition.width = -130
                    } else {
                        currentPosition.width = 0
                    }
                    targetPosition.width = currentPosition.width
                    dragOffset = .zero
                },
            including: .gesture
        )
        .background(alignment: .trailing) {
            SwipeActionView()
        }
        .onChange(of: swipedCellManager.currentlySwipedCellID) { _, newID in
            if newID != cellID {
                currentPosition = .zero
                targetPosition = .zero
            }
        }
    }
    
    @ViewBuilder
    private func SwipeActionView() -> some View {
        HStack(alignment: .center, spacing: ViewValues.Padding.default) {
            // Edit
            SwipeActionButton(
                appMainColorManager.appMainColor.mainColor,
                iconName: "square.and.pencil",
                position: targetPosition
            ) {
                withAnimation(.linear(duration: ViewValues.Duration.short)) {
                    currentPosition = .zero
                    targetPosition = .zero
                } completion: {
                    editAction()
                }
            }
            // Delete
            SwipeActionButton(
                .red,
                iconName: "trash",
                position: targetPosition
            ) {
                withAnimation(.linear(duration: ViewValues.Duration.short)) {
                    currentPosition = .zero
                    targetPosition = .zero
                } completion: {
                    deleteAction()
                }
            }
        }
        .padding(.horizontal, ViewValues.Padding.medium)
    }
}

//
fileprivate struct SwipeActionButton: View {
    private var color: Color
    private var iconName: String
    private var position: CGSize
    private var action: () -> Void
    
    init(
        _ color: Color,
        iconName: String,
        position: CGSize,
        action: @escaping () -> Void
    ) {
        self.color = color
        self.iconName = iconName
        self.position = position
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: ViewValues.Size.swipeActionButtonSize)
                    .foregroundStyle(color.opacity(ViewValues.Opacity.soft))
                Image(systemName: iconName)
                    .frame(width: ViewValues.Size.swipeActionIconSize)
                    .foregroundStyle(color)
            }
        }
        .opacity(min(max(-position.width / 130, 0), 1))
        .scaleEffect(min(max(-position.width / 130, 0), 1))
        .animation(.spring(duration: ViewValues.Duration.short), value: position)
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
                cellID: UUID(),
                title: "30분 러닝하기"
            ) {
                if isCompleted {
                    goalStreakCount += 1
                } else {
                    goalStreakCount -= 1
                }
            } editAction: {
                //
            } deleteAction: {
                //
            }
        }
        .padding(ViewValues.Padding.default)
    }
}

#Preview {
    GoalListCellPreview()
}
