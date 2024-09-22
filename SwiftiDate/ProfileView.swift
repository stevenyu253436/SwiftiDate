//
//  ProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var isShowingTurboPurchaseView = false // State variable to control the sheet presentation
    @State private var isShowingCrushPurchaseView = false // State variable to control Crush sheet presentation
    @State private var isShowingPraisePurchaseView = false // State variable to control Praise sheet presentation
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 头像及基本信息
                HStack {
                    Image("photo1") // 您需要替换为实际的头像图片名称
                        .resizable()
                        .frame(width: 100, height: 133)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)

                    NavigationLink(destination: EditProfileView()) { // Pass photos to EditProfileView
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue) // 改變圖標顏色來確保對比
                            .background(Color.white) // 可選，如果不需要可以去掉
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 4, x: 0, y: 2) // 加強陰影效果
                    }
                    .offset(x: -25, y: -25) // 调整按钮的位置
                    
                    VStack(alignment: .leading) {
                        Text("玩玩")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                            Text("已認證")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
                .padding()

                // 统计信息
                HStack(spacing: 50) {
                    VStack {
                        Text("0")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("喜歡我")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        Text("99+")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("我喜歡")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        Text("5")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("精選")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)

                // 成就进度条
                VStack {
                    Text("打敗 25.4%")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    ProgressView(value: 0.254)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .scaleEffect(x: 1, y: 4, anchor: .center)
                }
                .padding(.horizontal)
                
                // Turbo, Crush, 讚美
                HStack(spacing: 20) {
                    AchievementCardView(title: "TURBO", count: 0, color: Color.purple) {
                        isShowingTurboPurchaseView = true // Set the state to show the TurboPurchaseView
                    }
                    AchievementCardView(title: "CRUSH", count: 0, color: Color.green) {
                        isShowingCrushPurchaseView = true // Show CrushPurchaseView
                    }
                    AchievementCardView(title: "讚美", count: 0, color: Color.orange) {
                        isShowingPraisePurchaseView = true // Show PraisePurchaseView
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
                    PraisePurchaseView() // Present PraisePurchaseView when isShowingPraisePurchaseView is true
                }

                // 服務項目
                VStack(alignment: .leading, spacing: 10) {
                    Text("服務項目")
                        .font(.headline)
                        .padding(.top)

                    ServiceItemView(name: "更快篩選對的人", isAvailable: true)
                    ServiceItemView(name: "附近的人", isAvailable: true)
                    ServiceItemView(name: "高級篩選", isAvailable: true)
                    ServiceItemView(name: "每日精選", isAvailable: true)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct AchievementCardView: View {
    var title: String
    var count: Int
    var color: Color
    var action: (() -> Void)? // Optional action closure
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            Text("\(count)")
                .font(.title)
                .fontWeight(.bold)
            Button(action: {
                action?() // Execute the action if provided
            }) {
                Text("獲取更多")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
            }
        }
        .frame(width: 100, height: 100)
        .background(color.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ServiceItemView: View {
    var name: String
    var isAvailable: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
            if isAvailable {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView() // Now it works since we provided a default initializer with photos
        }
    }
}
