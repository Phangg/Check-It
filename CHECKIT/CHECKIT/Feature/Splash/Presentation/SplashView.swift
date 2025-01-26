//
//  SplashView.swift
//  CHECKIT
//
//  Created by phang on 1/10/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var appMainColorManager: AppMainColorManager
    //
    @State private var animationActive: Bool = false
    @Binding private var isFetched: Bool
    
    init(
        isFetched: Binding<Bool>
    ) {
        self._isFetched = isFetched
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: ViewValues.Padding.default) {
                // AppIcon
                ZStack(alignment: .center) {
                    // BG
                    RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                        .fill(animationActive ? appMainColorManager.appMainColor.mainColor : .cellLevel1)
                        .frame(
                            width: ViewValues.Size.cellBoxLarge,
                            height: ViewValues.Size.cellBoxLarge
                        )
                        .animation(
                            .easeInOut(duration: ViewValues.Duration.long),
                            value: animationActive
                        )
                    // Label
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .fontWeight(.heavy)
                        .frame(width: 60)
                        .foregroundStyle(animationActive ? .budWhite : .clear)
                        .animation(
                            .easeInOut(duration: ViewValues.Duration.long),
                            value: animationActive
                        )
                }
                // AppName
                Text(AppLocalized.AppName)
                    .font(.system(size: 60)) // TODO: font 수정 예정
                    .fontWeight(.heavy)
                    .foregroundStyle(animationActive ? .midGray : .budBlack)
                    .animatedStrikethrough(
                        isActive: animationActive,
                        color: .midGray,
                        height: 8,
                        duration: ViewValues.Duration.long - ViewValues.Duration.regular
                    )
            }
        }
        .onAppear { // TODO: 수정 예정
            Timer.scheduledTimer(withTimeInterval: ViewValues.Duration.medium, repeats: false) { _ in
                animationActive = true
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + ViewValues.Duration.long + ViewValues.Duration.medium
                ) {
                    isFetched = true
                }
            }
        }
    }
}
