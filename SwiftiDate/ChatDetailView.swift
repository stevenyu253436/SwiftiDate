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
    @Binding var messages: [Message]  // Bind to the messages passed from ChatView
    @State private var newMessageText: String = "" // State variable to hold the input message text
    @State private var phoneNumber: String = "1234567890" // Declare phoneNumber as a State variable
    var onBack: () -> Void // Add this line to accept the onBack closure

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    onBack() // Call the onBack closure when the button is pressed
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
                    if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                        if UIApplication.shared.canOpenURL(phoneURL) {
                            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                        } else {
                            print("無法撥打電話，請檢查電話號碼格式")
                        }
                    }
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
                ForEach(messages.indices, id: \.self) { index in
                    let message = messages[index]
                    let showTime = index == 0 || messages[index].time != messages[index - 1].time
                    
                    // Special check for the specific text message
                    if message.text == "她希望可以先聊天，再見面～" {
                        // Display this message as simple Text
                        HStack {
                            Text("她希望")
                                .foregroundColor(.green) // Set the color for the specific text

                            Text(message.text.replacingOccurrences(of: "她希望", with: "")) // Replace the specific text with an empty string
                                .foregroundColor(.black) // Default color for the rest of the text
                            
                            Spacer() // Add a Spacer to push the text to the left side
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading) // Align the entire HStack to the left
                        .background(Color.green.opacity(0.1)) // Apply background to the entire HStack
                        .cornerRadius(10) // Apply corner radius to the HStack
                        .padding(.horizontal) // Add horizontal padding around the whole HStack
                    } else {
                        // Display other messages as message bubbles
                        MessageBubbleView(message: message, isCurrentUser: message.isSender, showTime: showTime)
                            .padding(.horizontal)
                            .padding(.top, 5)
                    }
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
        .navigationBarHidden(true) // Hide the default navigation bar
    }

    private func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let newMessage = Message(id: UUID(), text: newMessageText, isSender: true, time: getCurrentTime(), isCompliment: false)
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
    var isCompliment: Bool // New property to indicate if the message is a compliment
}

// Custom view for message bubbles
struct MessageBubbleView: View {
    var message: Message
    var isCurrentUser: Bool
    var showTime: Bool // Add this new parameter

    var body: some View {
        VStack {
            if showTime {
                // Display the time when `showTime` is true
                Text(message.time)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center) // Center the time
            }
            
            HStack {
                if isCurrentUser {
                    Spacer()
                }
                
                Text(message.text)
                    .padding()
                    .background(isCurrentUser ? (message.isCompliment ? Color.black : Color.green) : Color.gray.opacity(0.3))
                    .foregroundColor(isCurrentUser ? .white : .black)
                    .cornerRadius(10)
                
                if !isCurrentUser {
                    Spacer()
                }
            }
            .padding(isCurrentUser ? .leading : .trailing, 50)
        }
    }
}


// PreviewProvider for ChatDetailView
struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy chat to preview
        let dummyChat = Chat(name: "Laiiiiiiii", time: "01:50", unreadCount: 3)
        
        ChatDetailView(chat: dummyChat, messages: .constant([
            Message(id: UUID(), text: "嗨～ 你有在這上面遇到什麼有趣的人嗎？", isSender: true, time: "09/12 15:53", isCompliment: false),
            Message(id: UUID(), text: "你要夠有趣的哈哈哈", isSender: false, time: "09/16 02:09", isCompliment: false),
            Message(id: UUID(), text: "我也不知道耶~", isSender: true, time: "09/20 15:03", isCompliment: false),
            Message(id: UUID(), text: "我喜歡旅遊、追劇、吃日料 ，偶爾小酌，妳平常喜歡做什麼？", isSender: true, time: "09/20 15:03", isCompliment: false),
            Message(id: UUID(), text: "還是像我一樣有趣的哈哈哈", isSender: true, time: "09/20 15:03", isCompliment: false),
            Message(id: UUID(), text: "跳舞跟唱歌", isSender: false, time: "09/21 01:50", isCompliment: false),
            Message(id: UUID(), text: "😂", isSender: false, time: "09/21 01:50", isCompliment: false),
            Message(id: UUID(), text: "吃美食跟看劇", isSender: false, time: "09/21 01:50", isCompliment: false)
        ]), onBack: {
            // Provide an empty closure or action for the onBack parameter
        })
    }
}
