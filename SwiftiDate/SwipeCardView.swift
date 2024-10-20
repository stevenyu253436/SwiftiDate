//
//  SwipeCardView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct User {
    let id: String
    let name: String
    let age: Int
    let zodiac: String
    let location: String
    let height: Int
    let photos: [String]
}

struct SwipeCardView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var offset = CGSize.zero
    @State private var showCircleAnimation = false
    @State private var showPrivacySettings = false // 控制隱私設置頁面的顯示
    @EnvironmentObject var userSettings: UserSettings
    @State private var showWelcomePopup = false // 初始值為 true，代表剛登入時顯示彈出視窗

    // List of users and current index
    @State private var users: [User] = [
        User(id: "userID_2", name: "後照鏡被偷", age: 20, zodiac: "雙魚座", location: "桃園市", height: 172, photos: [
            "userID_2_photo1", "userID_2_photo2", "userID_2_photo3", "userID_2_photo4", "userID_2_photo5", "userID_2_photo6"
        ]),
        User(id: "userID_3", name: "小明", age: 22, zodiac: "天秤座", location: "台北市", height: 180, photos: [
            "userID_3_photo1", "userID_3_photo2"
        ]),
        User(id: "userID_4", name: "小花", age: 25, zodiac: "獅子座", location: "新竹市", height: 165, photos: [
            "userID_4_photo1", "userID_4_photo2", "userID_4_photo3"
        ])
        // Add more users here
    ]
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            if locationManager.authorizationStatus == .authorizedWhenInUse ||
               locationManager.authorizationStatus == .authorizedAlways {
                // 使用者已授權位置存取，顯示滑動卡片畫面
                mainSwipeCardView
            } else {
                // 使用者未授權位置存取，顯示提示畫面
                locationPermissionPromptView
            }

            // 右上角的圖標，固定在整個螢幕的右上角
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // 顯示隱私設置畫面
                        showPrivacySettings = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            .padding(.top, 50)
                            .padding(.trailing, 20)
                    }
                }
                Spacer()
            }
            
            // 顯示彈出視窗
            if showWelcomePopup {
                welcomePopupView
            }
        }
        .edgesIgnoringSafeArea(.all) // 保證圖標能貼近螢幕邊緣
        .fullScreenCover(isPresented: $showPrivacySettings) {
            PrivacySettingsView() // 顯示隱私設置頁面
        }
    }
    
    // 主滑動卡片畫面
    var mainSwipeCardView: some View {
        ZStack {
            if showCircleAnimation {
                // 動態圓圈動畫頁面
                CircleExpansionView()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(radius: 5)

                    VStack {
                        TabView {
                            ForEach(users[currentIndex].photos, id: \.self) { photo in
                                Image(photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .padding()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 420)

                        Text("\(users[currentIndex].name), \(users[currentIndex].age)")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("\(users[currentIndex].zodiac) · \(users[currentIndex].location) · \(users[currentIndex].height) cm")
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                .frame(width: 350, height: 500)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                        }
                        .onEnded { _ in
                            if self.offset.width > 100 {
                                // Like gesture (right swipe)
                                handleSwipe(rightSwipe: true)
                            } else if self.offset.width < -100 {
                                // Dislike gesture (left swipe)
                                handleSwipe(rightSwipe: false)
                            } else {
                                // Reset position if not swiped enough
                                self.offset = .zero
                            }
                        }
                )
            }
        }
    }
    
    // Handle swipe action
    func handleSwipe(rightSwipe: Bool) {
        if rightSwipe {
            print("Like")
            userSettings.globalLikeCount += 1
        } else {
            print("Dislike")
        }

        // Move to the next user after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Go to the next user if available
            if currentIndex < users.count - 1 {
                currentIndex += 1
            } else {
                // No more users, show animation
                withAnimation {
                    showCircleAnimation = true
                }
                print("No more users")
            }
            // Reset offset
            self.offset = .zero
        }
    }
    
    // 位置權限提示畫面
    var locationPermissionPromptView: some View {
        VStack {
            Spacer()
            Image(systemName: "location.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            Text("來認識附近的新朋友吧")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)

            Text("SwiftiDate 需要你的 \"位置權限\" 才能幫你找到附近好友哦")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                locationManager.requestPermission()
            }) {
                Text("前往設置")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            Spacer()
        }
        .padding()
    }
    
    var welcomePopupView: some View {
        ZStack {
            // 半透明背景，覆蓋全屏
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 300, height: 400)
                        .shadow(radius: 10)
                    
                    VStack {
                        Image(systemName: "person.fill.checkmark")
                            .font(.system(size: 80))
                            .foregroundColor(.green)
                            .padding(.top, 40)
                        
                        Text("你喜歡什麼樣類型的？")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Text("我們會根據你的左滑和右滑了解你喜歡的類型，為你推薦更優質的用戶。")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            showWelcomePopup = false // 點擊按鈕時關閉彈出視窗
                        }) {
                            Text("知道了，開始吧！")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 20)
                        }
                    }
                    .padding()
                }
                .frame(width: 300, height: 400)
                Spacer()
            }
        }
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCardView()
            .previewDevice("iPhone 15 Pro Max") // 指定預覽設備為 iPhone 15 Pro Max
    }
}
