//
//  ChatView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
//
//  ChatView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            VStack {
                // 聊天列表
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // Custom title for new matches
                        Text("新配對")
                            .font(.headline)
                            .padding(.leading)

                        // 配對用戶的水平滾動
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                // The "More Matches" button
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.purple.opacity(0.1)) // Background circle
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: "bolt.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.purple)
                                        
                                        Circle()
                                            .stroke(Color.white, lineWidth: 0) // Outer white border
                                            .frame(width: 68, height: 68)
                                            .offset(x: 25, y: 25)
                                            .overlay(
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.white)
                                                    .background(Circle().fill(Color.purple))
                                                    .frame(width: 20, height: 20)
                                                    .offset(x: 20, y: 20)
                                            )
                                    }
                                    Text("更多配對")
                                        .font(.caption)
                                        .foregroundColor(.purple)
                                }
                                
                                // Existing users
                                ForEach(userMatches) { user in
                                    VStack {
                                        if let uiImage = UIImage(named: user.imageName) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                        } else {
                                            // Placeholder image when the actual image is not found
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .frame(width: 60, height: 60)
                                                .foregroundColor(.gray)
                                                .clipShape(Circle())
                                        }
                                        
                                        Text(user.name)
                                            .font(.caption)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // 聊天
                        Text("聊天")
                            .font(.headline)
                            .padding(.leading)

                        // 使用 List 顯示聊天對話
                        ForEach(chatData) { chat in
                            NavigationLink(destination: ChatDetailView(chat: chat)) {
                                ChatRow(chat: chat)
                            }
                            .buttonStyle(PlainButtonStyle()) // 去除默認點擊效果
                        }
                    }
                }
            }
            .navigationTitle("聊天")
        }
    }
}

// Define a structure for user match data
struct UserMatch: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String // Use image names stored in Assets
}

// Sample user match data
let userMatches = [
    UserMatch(name: "詐騙集團", imageName: "user1"),
    UserMatch(name: "ซูก้า", imageName: "user2"),
    UserMatch(name: "賣米當卡", imageName: "user3")
]

// 聊天行的顯示樣式
struct ChatRow: View {
    var chat: Chat
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.crop.circle.fill") // 您可以替換為實際圖片
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(chat.name)
                    .font(.headline)
                
                Text(chat.message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack {
                Text(chat.time)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if chat.unreadCount > 0 {
                    Text("\(chat.unreadCount)")
                        .font(.caption)
                        .padding(5)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 5)
    }
}

// 聊天模型
struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let unreadCount: Int
}

// 測試數據
let chatData = [
    Chat(name: "Laiiiiiiii", message: "吃美食跟看劇", time: "01:50", unreadCount: 3),
    Chat(name: "媽兒", message: "妳感覺起來很有氣質～是在做什麼的呢？😊", time: "09/20", unreadCount: 1),
    Chat(name: "兔兔", message: "我喜歡旅遊、追劇，吃日料，偶爾小酌，你平常...", time: "09/20", unreadCount: 0),
    Chat(name: "SwiftiDate", message: "😝6秒前有127人透過<戀人卡>完成了配對！", time: "09/15", unreadCount: 2),
    Chat(name: "心心", message: "真的嗎，一個月收入多少？", time: "09/15", unreadCount: 1)
]

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
