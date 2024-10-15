//
//  ChatView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
import SwiftUI

struct ChatView: View {
    @State private var selectedChat: Chat? = nil // State variable to handle navigation
    @AppStorage("userMatchesStorage") private var userMatchesString: String = "" // 使用 AppStorage 儲存 JSON 字符串
    @AppStorage("chatDataStorage") private var chatDataString: String = "" // 使用 AppStorage 儲存 JSON 字符串
    @AppStorage("chatMessagesStorage") private var chatMessagesString: String = "" // 使用 AppStorage 儲存 JSON 字符串
    @State private var showInteractiveContent = false // State variable to control InteractiveContentView display
    @State private var showTurboPurchaseView = false // State variable to control TurboPurchaseView display
    @State private var showTurboView = false // State variable to control TurboView display
    @State private var selectedTurboTab: Int = 0 // State variable to control Turbo tab selection
    @Binding var contentSelectedTab: Int // Use a binding variable for selectedTab from ContentView
    
    @State private var userMatches: [UserMatch] = [
        UserMatch(name: "詐騙集團", imageName: "user1"),
        UserMatch(name: "ซูก้า", imageName: "user2"),
        UserMatch(name: "賣米當卡", imageName: "user3")
    ] // 使用狀態變量來保存匹配用戶資料
    
    @State private var chatData: [Chat] = [
        Chat(name: "SwiftiDate", time: "09:15", unreadCount: 0),
        Chat(name: "霏", time: "09:15", unreadCount: 0),
        Chat(name: "Claire", time: "09:15", unreadCount: 0),
        Chat(name: "Laiiiiiiii", time: "09/21", unreadCount: 0),
        Chat(name: "嫣兒", time: "09/20", unreadCount: 0),
        Chat(name: "兔兔", time: "09/20", unreadCount: 0),
        Chat(name: "心心", time: "09/15", unreadCount: 1)
    ]
    
    // Dictionary to store messages for each chat
    @State private var chatMessages: [UUID: [Message]] = [:]

    init(contentSelectedTab: Binding<Int>) {
        self._contentSelectedTab = contentSelectedTab

        // 初始化 chatMessages，確保初始化之後再進行設置
        _chatMessages = State(initialValue: [
            chatData[0].id: [ // SwiftiDate messages for InteractiveContentView
                Message(id: UUID(), text: "😝6秒前有127人透過<戀人卡>完成了配對！", isSender: false, time: "09/15", isCompliment: false),
                Message(id: UUID(), text: "❤️ @玩玩，來找到真正適合自己的配對！", isSender: false, time: "09/15", isCompliment: false),
            ],
            chatData[1].id: [
                Message(id: UUID(), text: "你感覺起來很有氣質～是在做什麼的呢？ 😊", isSender: true, time: "09/20 15:03", isCompliment: false),
            ],
            chatData[2].id: [
                Message(id: UUID(), text: "嘿嘿！分享一首你最近在聽的歌吧～", isSender: true, time: "09/20 15:03", isCompliment: false),
            ],
            chatData[3].id: [
                Message(id: UUID(), text: "嗨～ 你有在這上面遇到什麼有趣的人嗎？", isSender: true, time: "09/12 15:53", isCompliment: false),
                Message(id: UUID(), text: "你要夠有趣的哈哈哈", isSender: false, time: "09/16 02:09", isCompliment: false),
                Message(id: UUID(), text: "我也不知道耶~", isSender: true, time: "09/20 15:03", isCompliment: false),
                Message(id: UUID(), text: "我喜歡旅遊、追劇、吃日料 ，偶爾小酌，妳平常喜歡做什麼？", isSender: true, time: "09/20 15:03", isCompliment: false),
                Message(id: UUID(), text: "還是像我一樣有趣的哈哈哈", isSender: true, time: "09/20 15:03", isCompliment: false),
                Message(id: UUID(), text: "跳舞跟唱歌", isSender: false, time: "09/21 01:50", isCompliment: false),
                Message(id: UUID(), text: "😂", isSender: false, time: "09/21 01:50", isCompliment: false),
                Message(id: UUID(), text: "吃美食跟看劇", isSender: false, time: "09/21 01:50", isCompliment: false)
            ],
            chatData[4].id: [
                Message(id: UUID(), text: "她希望可以先聊天，再見面～", isSender: false, time: "09/13 22:44", isCompliment: false),
                Message(id: UUID(), text: "妳感覺起來很有氣質～", isSender: true, time: "09/20 15:03", isCompliment: true),
                Message(id: UUID(), text: "謝謝", isSender: false, time: "09/20 15:03", isCompliment: false),
                Message(id: UUID(), text: "你感覺起來很有氣質～是在做什麼的呢？ 😊", isSender: true, time: "09/20 15:03", isCompliment: false)
            ],
            chatData[5].id: [
                Message(id: UUID(), text: "你感覺起來很有氣質～是在做什麼的呢？ 😊", isSender: true, time: "09/20 15:03", isCompliment: true),
                Message(id: UUID(), text: "我已通過你的好友請求，我們可以開始聊天啦～", isSender: false, time: "09/19 14:10", isCompliment: false),
                Message(id: UUID(), text: "我喜歡旅遊、追劇、吃日料，偶爾小酌，你平常喜歡做什麼？", isSender: true, time: "09/20 15:03", isCompliment: false)
            ]
        ])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let chat = selectedChat {
                    ChatDetailView(chat: chat, messages: Binding(get: {
                        chatMessages[chat.id] ?? []
                    }, set: { newValue in
                        chatMessages[chat.id] = newValue
                    }), onBack: {
                        selectedChat = nil // Reset to show ChatView again
                    })
                } else if showInteractiveContent {
                    InteractiveContentView(onBack: { // Add this closure to handle onBack for InteractiveContentView
                        showInteractiveContent = false // Reset to show ChatView again
                    })
                } else {
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
                                    .onTapGesture {
                                        showTurboPurchaseView = true // Navigate to TurboPurchaseView
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
                            
                            // Add the 'WhoLikedYouView' at the top
                            Button(action: {
                                showTurboView = true // Navigate to TurboView
                            }) {
                                WhoLikedYouView()
                                    .padding(.top)
                            }

                            // 使用 List 顯示聊天對話
                            ForEach(chatData) { chat in
                                if let messages = chatMessages[chat.id] {
                                    Button(action: {
                                        if chat.name == "SwiftiDate" { // Adjust to your actual name for SwiftiDate
                                            showInteractiveContent = true // Navigate to InteractiveContentView
                                            selectedChat = nil
                                        } else {
                                            showInteractiveContent = false
                                            selectedChat = chat // Navigate to ChatDetailView
                                        }
                                    }) {
                                        ChatRow(chat: chat, messages: messages) // Pass messages to ChatRow
                                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                                // "解除配對" button
                                                Button {
                                                    // Handle unmatch action
                                                    print("解除配對 tapped")
                                                } label: {
                                                    Text("解除配對")
                                                }
                                                .tint(.gray)

                                                // "修改備註名稱" button
                                                Button {
                                                    // Handle rename action
                                                    print("修改備註名稱 tapped")
                                                } label: {
                                                    Text("修改備註名稱")
                                                }
                                                .tint(.green)
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("聊天") // Ensure this is applied to the VStack
            .fullScreenCover(isPresented: $showTurboView) {
                // Pass the selectedTab to TurboView
                TurboView(contentSelectedTab: $contentSelectedTab, turboSelectedTab: $selectedTurboTab, showBackButton: true, onBack: {
                    showTurboView = false // This dismisses the TurboView
                })
            }
            .sheet(isPresented: $showTurboPurchaseView) {
                TurboPurchaseView() // Present TurboPurchaseView when showTurboPurchaseView is true
            }
        }
    }
    
    // 將 chatMessages 編碼為 JSON 字符串並存入 AppStorage
    private func saveChatMessagesToAppStorage() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(chatMessages)
            chatMessagesString = String(data: data, encoding: .utf8) ?? ""
        } catch {
            print("Failed to encode chatMessages: \(error)")
        }
    }

    // 從 AppStorage 載入聊天消息
    private func loadChatMessagesFromAppStorage() {
        guard !chatMessagesString.isEmpty else {
            print("No chat messages found in AppStorage")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            if let data = chatMessagesString.data(using: .utf8) {
                chatMessages = try decoder.decode([UUID: [Message]].self, from: data)
            }
        } catch {
            print("Failed to decode chatMessages: \(error)")
        }
    }

    // 添加或更新聊天消息
    private func updateChatMessages(for chatID: UUID, messages: [Message]) {
        chatMessages[chatID] = messages
        saveChatMessagesToAppStorage() // 保存至 AppStorage
    }
}

struct ChatView_Previews: PreviewProvider {
    @State static var contentSelectedTab = 3 // Add the required state variable
    
    static var previews: some View {
        ChatView(contentSelectedTab: $contentSelectedTab) // Pass the binding to the contentSelectedTab
    }
}
