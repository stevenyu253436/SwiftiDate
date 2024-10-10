//
//  LoginView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/11.
//

import Foundation
import SwiftUI

struct LoginView: View {
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
                    
                    Button(action: {
                        // Facebook 登入按鈕的動作
                    }) {
                        HStack {
                            Image(systemName: "f.square.fill")
                            Text("使用 Facebook 帳號登入")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                        .padding(.horizontal)
                    }
                    
                    Button(action: {
                        // Apple ID 登入按鈕的動作
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("使用 Apple ID 帳號登入")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(25)
                        .padding(.horizontal)
                    }
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
