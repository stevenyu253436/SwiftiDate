//
//  TurboView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct TurboView: View {
    @Binding var selectedTab: Int // This is now a @Binding property to accept external changes
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
                            selectedTab = 0
                        }) {
                            Text("喜歡我的人")
                                .font(.headline)
                                .foregroundColor(selectedTab == 0 ? .green : .gray)
                                .frame(maxWidth: .infinity) // 讓按鈕自適應空間
                        }
                                            
                        Button(action: {
                            selectedTab = 1
                        }) {
                            Text("我的心動對象")
                                .font(.headline)
                                .foregroundColor(selectedTab == 1 ? .green : .gray) // Corrected logic
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
                            selectedTab == 0 ? 0 : -UIScreen.main.bounds.width / 2 // Align the Rectangle to either the left or right side
                        }
                }
                .frame(width: UIScreen.main.bounds.width, alignment: selectedTab == 0 ? .leading : .trailing) // Align HStack based on the selected tab

                Spacer().frame(height: 20)
                
                if selectedTab == 0 {
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
                    Spacer()
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
    @State static var selectedTab = 0
    
    static var previews: some View {
        Group {
            TurboView(selectedTab: $selectedTab, showBackButton: true, onBack: {
                print("返回到上一頁")
            })
            .previewDevice("iPhone 15 Pro")

            TurboView(selectedTab: $selectedTab, showBackButton: false)
            .previewDevice("iPhone 15 Pro")
        }
    }
}
