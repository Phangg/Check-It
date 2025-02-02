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
    @StateObject private var container: MVIContainer<SplashIntent, SplashModelState>
    private var intent: SplashIntent { container.intent }
    private var state: SplashModelState { container.model }
        
    init(
        onFetchComplete: @escaping () -> Void
    ) {
        let model = SplashModelImp()
        let intent = SplashIntentImp(
            model: model,
            onFetchComplete: onFetchComplete
        )
        let container = MVIContainer(
            intent: intent as SplashIntent,
            model: model as SplashModelState,
            modelChangePublisher: model.objectWillChange
        )
        self._container = StateObject(wrappedValue: container)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: ViewValues.Padding.default) {
                // AppIcon
                ZStack(alignment: .center) {
                    // BG
                    RoundedRectangle(cornerRadius: ViewValues.Radius.default)
                        .fill(state.animationActive ? appMainColorManager.appMainColor.mainColor : .cellLevel1)
                        .frame(
                            width: ViewValues.Size.cellBoxLarge,
                            height: ViewValues.Size.cellBoxLarge
                        )
                        .animation(
                            .easeInOut(duration: ViewValues.Duration.long),
                            value: state.animationActive
                        )
                    // Label
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .fontWeight(.heavy)
                        .frame(width: 60)
                        .foregroundStyle(state.animationActive ? .budWhite : .clear)
                        .animation(
                            .easeInOut(duration: ViewValues.Duration.long),
                            value: state.animationActive
                        )
                }
                // AppName
                Text(AppLocalized.AppName)
                    .font(.system(size: 60)) // TODO: font 수정 예정
                    .fontWeight(.heavy)
                    .foregroundStyle(state.animationActive ? .midGray : .budBlack)
                    .animatedStrikethrough(
                        isActive: state.animationActive,
                        color: .midGray,
                        height: 8,
                        duration: ViewValues.Duration.long - ViewValues.Duration.regular
                    )
            }
        }
        .onAppear {
            intent.handleOnAppear()
        }
    }
}
