//
//  LoginView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/11.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var authorizationController: ASAuthorizationController?
    @State private var showExistingUserPopup = true // 控制彈框顯示
    @State private var existingUserName: String = "" // 儲存已存在的用戶名稱

    @EnvironmentObject var userSettings: UserSettings // 使用 @EnvironmentObject 來訪問 UserSettings
    
    var body: some View {
        ZStack {
            // 背景顏色
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // 中間的標誌
                Text("SwiftiDate")
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)
                
                // 登入選項按鈕
                VStack(spacing: 20) {
                    Button(action: {
                        // 行動電話登入按鈕的動作
                    }) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("使用手機號碼登入")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                        .padding(.horizontal)
                    }
                    
//                    Button(action: {
//                        // Facebook 登入按鈕的動作
//                    }) {
//                        HStack {
//                            Image(systemName: "f.square.fill")
//                            Text("使用 Facebook 帳號登入")
//                                .fontWeight(.bold)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(25)
//                        .padding(.horizontal)
//                    }
                    
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                handleAuthorizationResult(authResults)
                            case .failure(let error):
                                print("Authorization failed: \(error.localizedDescription)")
                            }
                        }
                    )
                    .frame(height: 45)
                    .signInWithAppleButtonStyle(.white)
                    .cornerRadius(25)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // 隱私政策及服務條款
                Text("SwiftiDate 不會在你的 Facebook 上發文")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 5)
                
                HStack {
                    Text("服務協議")
                        .underline()
                        .foregroundColor(.white.opacity(0.8))
                    Text("&")
                        .foregroundColor(.white.opacity(0.8))
                    Text("隱私權政策")
                        .underline()
                        .foregroundColor(.white.opacity(0.8))
                }
                .font(.footnote)
                .padding(.bottom, 20)
            }
            
            // 彈框顯示部分
            if showExistingUserPopup {
                Color.black.opacity(0.4).ignoresSafeArea() // 背景透明遮罩

                VStack(spacing: 20) {
                    Image("photo1")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle()) // 讓圖片變成圓形
                        .overlay(Circle().stroke(Color.white, lineWidth: 4)) // 加上白色的圓形邊框
                    
                    Text(existingUserName)
                        .font(.subheadline)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        // 確定以此帳號登入
                        print("繼續使用帳號 \(existingUserName)")
                        showExistingUserPopup = false
                    }) {
                        Text("以此帳號登入")
                            .foregroundColor(.white)
                            .frame(width: 250, height: 45)
                            .background(Color.blue)
                            .cornerRadius(22.5)
                    }
                    
                    Button(action: {
                        // 更換帳號並清除所有已存資料
                        clearUserState()
                        print("換個帳號")
                        showExistingUserPopup = false
                    }) {
                        Text("換個帳號")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                }
                .frame(width: 300, height: 350)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            // 在 LoginView 出現時加載用戶狀態
            loadUserState()
        }
    }
    
    // 處理 Apple ID 登入結果
    func handleAuthorizationResult(_ result: ASAuthorization) {
        guard let credential = result.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        
        let userID = credential.user
        let email = credential.email
        let fullName = credential.fullName
        
        // 在這裡處理登錄信息，例如存儲用戶信息到本地或服務器
        print("User ID: \(userID)")
        if let email = email {
            print("Email: \(email)")
        }
        if let fullName = fullName {
            print("Full Name: \(fullName)")
        }
    }
    
    // 加載邏輯
    func loadUserState() {
        let defaults = UserDefaults.standard
        userSettings.globalPhoneNumber = defaults.string(forKey: "phoneNumber") ?? "未設定"
        userSettings.globalUserName = defaults.string(forKey: "userName") ?? "未設定"

        if !userSettings.globalUserName.isEmpty {
            existingUserName = userSettings.globalUserName
            showExistingUserPopup = true // 如果有已存的帳號數據則顯示彈框
        }
        
        if let genderValue = defaults.string(forKey: "userGender"), let gender = Gender(rawValue: genderValue) {
            userSettings.globalUserGender = gender // Correctly set the Gender enum
        }

        userSettings.globalIsUserVerified = defaults.bool(forKey: "isUserVerified")

        globalTurboCount = defaults.integer(forKey: "turboCount")
        globalCrushCount = defaults.integer(forKey: "crushCount")
        globalPraiseCount = defaults.integer(forKey: "praiseCount")
        
        userSettings.globalLikesMeCount = defaults.integer(forKey: "likesMeCount")
        userSettings.globalLikeCount = defaults.integer(forKey: "likeCount")
        
        userSettings.isSupremeUser = defaults.bool(forKey: "isSupremeUser")
    }
    
    func clearUserState() {
        let defaults = UserDefaults.standard
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain) // 清除所有的UserDefaults資料
        }
        defaults.synchronize() // 確保立即保存

        // 清除全局變數
        userSettings.globalPhoneNumber = ""
        userSettings.globalUserName = ""
        userSettings.storedGender = Gender.male.rawValue // Use storedGender for reset
        userSettings.globalIsUserVerified = false
        globalTurboCount = 0
        globalCrushCount = 0
        globalPraiseCount = 0
        userSettings.globalLikesMeCount = 0
        userSettings.globalLikeCount = 0
        userSettings.isSupremeUser = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserSettings()) // Provide the environment object for UserSettings
    }
}
