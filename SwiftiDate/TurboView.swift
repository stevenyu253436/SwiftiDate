//
//  TurboView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct TurboView: View {
    @ObservedObject var userSettings = UserSettings() // Add this to observe the UserSettings
    @Binding var localSelectedTab: Int // Rename to avoid ambiguity with ContentView's selectedTab
    var showBackButton: Bool = false // 這裡新增一個參數來控制是否顯示chevron.left
    @State private var showConfirmationPopup = false // State to control the visibility of the confirmation popup

    var onBack: (() -> Void)? // 返回按鈕的閉包操作
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .topLeading) {
                    // Custom Navigation Bar with chevron.left button
                    HStack {
                        if showBackButton {
                            Button(action: {
                                onBack?() // 執行返回操作
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 16) // 增加一點左邊的間距
                        }

                        Spacer() // 把BackButton推到左邊
                    }
                    
                    // Top Tab Selection
                    HStack {
                        Button(action: {
                            localSelectedTab = 0
                        }) {
                            Text("喜歡我的人")
                                .font(.headline)
                                .foregroundColor(localSelectedTab == 0 ? .green : .gray)
                                .frame(maxWidth: .infinity) // 讓按鈕自適應空間
                        }
                                            
                        Button(action: {
                            localSelectedTab = 1
                        }) {
                            Text("我的心動對象")
                                .font(.headline)
                                .foregroundColor(localSelectedTab == 1 ? .green : .gray)
                                .frame(maxWidth: .infinity) // 讓按鈕自適應空間
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }

                // The selected line
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2, height: 2) // Set the width to half the screen size
                        .foregroundColor(.green)
                        .alignmentGuide(.leading) { d in
                            localSelectedTab == 0 ? 0 : -UIScreen.main.bounds.width / 2
                        }
                }
                .frame(width: UIScreen.main.bounds.width, alignment: localSelectedTab == 0 ? .leading : .trailing)

                Spacer().frame(height: 20)
                
                if localSelectedTab == 0 {
                    // The featured card section (每日精選)
                    FeaturedCardView()

                    Spacer().frame(height: 20)
                    
                    // Main image
                    Image("turbo_view_image") // Replace with your image asset name
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                    
                    // Description text
                    Text("開啟Turbo，將你直接置頂到所有人的前面！輕鬆提升10倍配對成功率")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    // Action button
                    Button(action: {
                        if globalTurboCount > 0 {
                            // Show confirmation popup if TurboCount is greater than 0
                            showConfirmationPopup = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "bolt.fill")
                            
                            Text("馬上開始")
                                .fontWeight(.bold)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 60)
                    }
                    .padding(.vertical, 20)

                    Spacer()
                    
                    Button(action: {
                        if globalTurboCount > 0 {
                            // Show confirmation popup if TurboCount is greater than 0
                            showConfirmationPopup = true
                        }
                    }) {
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                } else {
                    if userSettings.globalLikeCount == 0 { // Access globalLikeCount from UserSettings
                        VStack {
                            Spacer()
                            Image(systemName: "cube.box")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                            Text("你還沒有送出喜歡，快去滑動吧")
                                .foregroundColor(.gray)
                                .padding(.top, 16)
                            
                            Button(action: {
                                // Action for 去滑卡 button
                            }) {
                                Text("去滑卡")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 60)
                            }
                            Spacer()
                        }
                    } else {
                        Spacer()
                    }
                }
            }
            
            // Confirmation popup overlay using ZStack
            if showConfirmationPopup {
                Color.black.opacity(0.8) // Background with high opacity
                    .edgesIgnoringSafeArea(.all) // Cover the entire screen
                
                VStack(spacing: 20) {
                    // Profile image
                    Image("photo1") // Replace with your actual image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4)
                        )
                    
                    Text("確認要立即使用Turbo嗎？")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        // Confirm action to use Turbo
                        showConfirmationPopup = false
                    }) {
                        Text("確認使用")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Dismiss the confirmation popup
                        showConfirmationPopup = false
                    }) {
                        Text("取消")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal, 40)
            }
        }
    }
}

// MARK: - TurboView Preview
struct TurboView_Previews: PreviewProvider {
    @State static var localSelectedTab = 1 // Renamed here too

    static var previews: some View {
        TurboView(localSelectedTab: $localSelectedTab, showBackButton: false)
        .previewDevice("iPhone 15 Pro")
    }
}
