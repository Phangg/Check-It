//
//  AppNameLogo.swift
//  CHECKIT
//
//  Created by phang on 1/13/25.
//

import SwiftUI

struct AppNameLogo: View {
    @EnvironmentObject private var appMainColorManager: AppMainColorManager

    private let columns = Array(repeating: GridItem(.flexible(), spacing: ViewValues.Padding.small), count: 14)
    
    var body: some View {
        VStack(alignment: .center, spacing: ViewValues.Padding.zero) {
            //
            LazyVGrid(columns: columns, alignment: .center, spacing: ViewValues.Padding.small) {
                ForEach(0..<14 * 4, id: \.self) { item in
                    GrowCell(type: .small, backgroundColor: appMainColorManager.appMainColor.mainColor)
                }
            }
            // App Name
            Text(AppLocalized.AppName.uppercased())
                .font(.system(size: 77)) // TODO: 폰트 설정 필요
                .fontWeight(.heavy)
            //
            LazyVGrid(columns: columns, alignment: .center, spacing: ViewValues.Padding.small) {
                ForEach(0..<14 * 3, id: \.self) { item in
                    GrowCell(type: .small, backgroundColor: appMainColorManager.appMainColor.mainColor)
                }
            }
        }
    }
}

#Preview {
    AppNameLogo()
}
