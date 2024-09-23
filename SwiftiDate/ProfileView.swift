//
//  ProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

extension Color {
    static let gold = Color(red: 212 / 255, green: 175 / 255, blue: 55 / 255) // Custom gold color
}

struct ProfileView: View {
    @State private var isShowingTurboPurchaseView = false // State variable to control the sheet presentation
    @State private var isShowingCrushPurchaseView = false // State variable to control Crush sheet presentation
    @State private var isShowingPraisePurchaseView = false // State variable to control Praise sheet presentation
    @State private var isSupremeUser = true // Replace this with your actual logic to determine if the user is Supreme

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
                
                // Display Supreme banner if the user has purchased Supreme
                if isSupremeUser {
                    HStack {
                        Image(systemName: "crown.fill") // Adding the crown icon
                            .foregroundColor(.gold) // Matching the gold color
                            .font(.system(size: 18)) // Adjust the size as needed
                        
                        VStack(alignment: .leading) {
                            Text("SwiftiDate Supreme")
                                .font(.headline)
                                .foregroundColor(.gold) // Set text color to gold
                                .fontWeight(.bold)
                            
                            Text("已開啟 SwiftiDate 所有特權")
                                .font(.subheadline)
                                .foregroundColor(.gold)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // 服務項目
                    VStack(alignment: .leading, spacing: 10) {
                        // Service Section Title
                        HStack {
                            Text("服務項目")
                                .font(.headline)
                                .padding(.top)

                            Spacer() // This spacer will push the next text to the right side

                            VStack(alignment: .trailing) {
                                Text("Supreme")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)

                                Text("16項特權")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)

                        // Service sections
                        ServiceSectionView(
                            sectionTitle: "更快篩選對的人",
                            totalItems: 4,
                            services: [
                                ("附近的人", true, nil),
                                ("高級篩選", true, nil),
                                ("每日精選", true, nil),
                                ("額外的喜歡次數", false, "∞")
                            ]
                        )
                        
                        // Adding the "獲取更多配對" ServiceSectionView
                        ServiceSectionView(
                            sectionTitle: "獲取更多配對",
                            totalItems: 7,
                            services: [
                                ("免費讚美", true, "3/天"),
                                ("免費的Crush", true, "5/天"),
                                ("免費Turbo", true, "1/月"),
                                ("看看誰喜歡你", true, nil),
                                ("開啟心動列表", true, nil),
                                ("免費的反悔機會", false, "∞"),
                                ("找回已解除的配對", true, nil)
                            ]
                        )
                        
                        // Adding the "升級體驗" ServiceSectionView
                        ServiceSectionView(
                            sectionTitle: "升級體驗",
                            totalItems: 5,
                            services: [
                                ("隱身模式", true, nil),
                                ("24小時專屬客服", true, nil),
                                ("已讀回執", true, nil),
                                ("專屬會員標誌", true, nil),
                                ("不限次數的「緣分合盤」解讀", true, nil)
                            ]
                        )
                    }
                    .padding(.horizontal)
                }
                
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

struct ServiceSectionView: View {
    var sectionTitle: String
    var totalItems: Int
    var services: [(name: String, isAvailable: Bool, count: String?)] // (Service name, availability, count)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Service items
            VStack(spacing: 5) {
                // Title and total items count
                HStack {
                    Text(sectionTitle)
                        .font(.headline)

                    Spacer()
                    
                    Text("\(totalItems)項")
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                
                ForEach(services, id: \.name) { service in
                    HStack {
                        Text(service.name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if let count = service.count {
                            Text(count)
                                .font(.subheadline)
                        } else if service.isAvailable {
                            Image(systemName: "checkmark")
                        } else {
                            Image(systemName: "infinity")
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView() // Now it works since we provided a default initializer with photos
        }
    }
}
