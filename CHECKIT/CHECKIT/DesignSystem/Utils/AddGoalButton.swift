//
//  AddGoalButton.swift
//  CHECKIT
//
//  Created by phang on 1/11/25.
//

import SwiftUI

struct AddGoalButton: View {
    // For managing button animation
    @State private var isPressed = false
    
    private let action: () -> Void
    
    init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            // BG
            RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                .fill(.blue.opacity(0.1)) // TODO: color 수정 필요
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
                                action()
                            }
                        }
                )
            // Label
            Image(systemName: "plus")
                .font(.title2)
                .foregroundStyle(.midGray)
                .scaleEffect(isPressed ? ViewValues.Scale.pressed : ViewValues.Scale.default)
        }
    }
}

#Preview {
    AddGoalButton {
        print("Tap AddGoalButton")
    }
    .padding(ViewValues.Padding.default)
}
