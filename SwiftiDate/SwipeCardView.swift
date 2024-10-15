//
//  SwipeCardView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct SwipeCardView: View {
    @State private var offset = CGSize.zero
    @State private var showCircleAnimation = false
    @State private var showPrivacySettings = false // 控制隱私設置頁面的顯示

    // Inject UserSettings to access globalLikeCount and other variables
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
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
                        Image("profile_picture_others")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 25))

                        Text("後照鏡被偷, 20")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("雙魚座 · 桃園市 · 172 cm")
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
                                // 右滑動
                                print("Like")
                                withAnimation {
                                    showCircleAnimation = true
                                }
                                // Increment globalLikeCount
                                userSettings.globalLikeCount += 1
                                print("Total Likes: \(userSettings.globalLikeCount)")
                            } else if self.offset.width < -100 {
                                // 左滑動
                                print("Dislike")
                                withAnimation {
                                    showCircleAnimation = true
                                }
                            } else {
                                // 恢復原位
                                self.offset = .zero
                            }
                        }
                )
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
        }
        .edgesIgnoringSafeArea(.all) // 保證圖標能貼近螢幕邊緣
        .fullScreenCover(isPresented: $showPrivacySettings) {
            PrivacySettingsView() // 顯示隱私設置頁面
        }
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCardView()
            .previewDevice("iPhone 15 Pro Max") // 指定預覽設備為 iPhone 15 Pro Max
    }
}
