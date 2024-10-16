//
//  AchievementSectionView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import SwiftUI

struct AchievementSectionView: View {
    @EnvironmentObject var userSettings: UserSettings
    @Binding var isShowingTurboPurchaseView: Bool
    @Binding var isShowingCrushPurchaseView: Bool
    @Binding var isShowingPraisePurchaseView: Bool

    var body: some View {
        HStack(spacing: 20) {
            AchievementCardView(title: "TURBO", count: userSettings.globalTurboCount, color: Color.purple) {
                isShowingTurboPurchaseView = true
            }
            AchievementCardView(title: "CRUSH", count: userSettings.globalCrushCount, color: Color.green) {
                isShowingCrushPurchaseView = true
            }
            AchievementCardView(title: "讚美", count: userSettings.globalPraiseCount, color: Color.orange) {
                isShowingPraisePurchaseView = true
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $isShowingTurboPurchaseView) {
            TurboPurchaseView()
        }
        .sheet(isPresented: $isShowingCrushPurchaseView) {
            CrushPurchaseView()
        }
        .sheet(isPresented: $isShowingPraisePurchaseView) {
            PraisePurchaseView()
        }
    }
}
