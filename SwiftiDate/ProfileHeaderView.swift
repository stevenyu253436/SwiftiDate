//
//  ProfileHeaderView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import SwiftUI

struct ProfileHeaderView: View {
    @Binding var isShowingEditProfileView: Bool
    @Binding var photos: [String]
    @EnvironmentObject var userSettings: UserSettings // 使用 EnvironmentObject 來存取 UserSettings

    var body: some View {
        HStack {
            if let firstPhotoName = photos.first, let image = PhotoUtility.loadImageFromLocalStorage(named: firstPhotoName) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 133)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } else {
                // 顯示預設的佔位符圖片
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 133)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }

            Button(action: {
                isShowingEditProfileView = true // 顯示 EditProfileView
            }) {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
            }
            .offset(x: -25, y: -25)
            .fullScreenCover(isPresented: $isShowingEditProfileView) {
                EditProfileView(photos: $photos)
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(userSettings.globalUserName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if userSettings.isSupremeUser {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.gold)
                            .font(.system(size: 18))
                    }
                }
                
                if userSettings.globalIsUserVerified {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                        Text("已認證")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
