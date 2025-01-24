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
        Button {
            action()
        } label: {
            ZStack(alignment: .center) {
                // BG
                RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                    .fill(.accent.opacity(0.1)) // TODO: color 수정 필요
                    .overlay {
                        RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                            .fill(isPressed ? .budBlack.opacity(ViewValues.Opacity.light) : .clear)
                    }
                    .frame(height: ViewValues.Size.goalCellHeight)
                // Label
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.midGray)
            }
        }
        .buttonStyle(PressButtonStyle(isPressed: $isPressed))
    }
}

#Preview {
    AddGoalButton {
        print("Tap AddGoalButton")
    }
    .padding(ViewValues.Padding.default)
}
