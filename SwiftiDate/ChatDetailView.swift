//
//  ChatDetailView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/22.
//

import Foundation
import SwiftUI

struct ChatDetailView: View {
    var chat: Chat
    @State private var messages: [Message] = [] // Store messages for this chat
    @State private var newMessageText: String = "" // State variable to hold the input message text

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    // Action for back button
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                }

                Image(systemName: "person.crop.circle.fill") // Avatar Image (replace with actual image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.leading, 5)

                Text(chat.name)
                    .font(.headline)
                    .padding(.leading, 5)
                
                Image(systemName: "bell.fill") // Notification Bell Icon
                    .foregroundColor(.pink)
                    .padding(.leading, 5)

                Spacer()
                
                Button(action: {
                    // Action for phone call
                }) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.green)
                        .padding(.trailing, 10)
                }
                
                Button(action: {
                    // Action for more options
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                }
            }
            .frame(height: 60)
            .background(Color.white)
            
            Divider() // Divider line
            
            ScrollView {
                ForEach(messages) { message in
                    MessageBubbleView(message: message, isCurrentUser: message.isSender)
                        .padding(.horizontal)
                        .padding(.top, 5)
                }
            }
            
            HStack {
                TextField("輸入聊天內容", text: $newMessageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                }
            }
            .padding()
        }
        .onAppear {
            loadMessages(for: chat)
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func loadMessages(for chat: Chat) {
        // Fetch messages from your data source (e.g., Firebase, local database)
        // Dummy data for testing
        messages = [
            Message(id: UUID(), text: "你好呀", isSender: false, time: "10:20 AM"),
            Message(id: UUID(), text: "嗨！最近怎麼樣？", isSender: true, time: "10:21 AM")
        ]
    }

    private func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let newMessage = Message(id: UUID(), text: newMessageText, isSender: true, time: getCurrentTime())
        messages.append(newMessage)
        
        // Clear the text field
        newMessageText = ""
        
        // Code to send a new message and update the conversation in your data source can be added here
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }
}

// Message model
struct Message: Identifiable {
    let id: UUID
    let text: String
    let isSender: Bool
    let time: String
}

// Custom view for message bubbles
struct MessageBubbleView: View {
    var message: Message
    var isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            
            Text(message.text)
                .padding()
                .background(isCurrentUser ? Color.green : Color.gray.opacity(0.3))
                .foregroundColor(isCurrentUser ? .white : .black)
                .cornerRadius(10)
            
            if !isCurrentUser {
                Spacer()
            }
        }
        .padding(isCurrentUser ? .leading : .trailing, 50)
    }
}


// PreviewProvider for ChatDetailView
struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy chat to preview
        let dummyChat = Chat(name: "Laiiiiiiii", message: "吃美食跟看劇", time: "01:50", unreadCount: 3)
        
        ChatDetailView(chat: dummyChat)
    }
}
