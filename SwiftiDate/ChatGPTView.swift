//
//  ChatGPTView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/9.
//

import Foundation
import SwiftUI

struct ChatGPTView: View {
    @State private var chatHistory: [Message] = []   // 聊天歷史記錄
    @State private var userInput: String = ""   // 用戶輸入的訊息
    @State private var chatGPTResponse: String = ""  // GPT 的回應
    @State private var isLoading = false        // 用來顯示加載狀態
    
    let apiKey = openAIAPIKey  // 將這個替換為您的 API 密鑰

    var body: some View {
        VStack {
            Text("ChatGPT-4o")
                .font(.title)
                .padding()
            
            ScrollView {
                ForEach(chatHistory, id: \.id) { message in
                    HStack {
                        Text(message.isSender ? "你: " : "對方: ")
                            .fontWeight(.bold)
                        Text(message.text)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                Text(chatGPTResponse)  // 顯示 ChatGPT 的建議回應
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
            }
            .frame(height: 300)
            .border(Color.gray, width: 1)

            TextField("輸入您的訊息...", text: $userInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            if isLoading {
                ProgressView()  // 顯示加載中狀態
                    .padding()
            }

            Button(action: {
                sendMessageToChatGPT()  // 發送用戶輸入給 ChatGPT
            }) {
                Text("發送")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    // 與 OpenAI API 進行交互的函數
    func sendMessageToChatGPT() {
        guard !userInput.isEmpty else { return }

        isLoading = true
        
        // 構建聊天歷史記錄，將其轉換為 OpenAI API 所需的格式
        var messages: [[String: String]] = chatHistory.map { message in
            [
                "role": message.isSender ? "user" : "assistant", // 如果是用戶發送的訊息，標記為 "user"，否則為 "assistant"
                "content": message.text
            ]
        }
        
        // 添加用戶輸入的問題作為最後一條記錄
        messages.append([
            "role": "user",
            "content": userInput
        ])
        
        // 準備 API 請求
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 設置請求 body，將聊天記錄和新問題一起發送
        let body: [String: Any] = [
            "model": "gpt-4", // 使用 gpt-4 模型
            "messages": messages
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        // 發送請求
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            // 確保沒有錯誤且數據正確
            guard let data = data, error == nil else {
                print("API請求失敗：\(error?.localizedDescription ?? "未知錯誤")")
                return
            }
            
            // 解碼 API 回應
            if let response = try? JSONDecoder().decode(ChatGPTResponse.self, from: data) {
                DispatchQueue.main.async {
                    if let chatResponseText = response.choices.first?.message.content {
                        // 顯示 GPT 回應
                        chatGPTResponse = chatResponseText
                    } else {
                        // 如果沒有回應，顯示 "對方未回應"
                        chatGPTResponse = "對方未回應"
                    }
                    chatHistory.append(Message(id: UUID(), text: userInput, isSender: true, time: getCurrentTime(), isCompliment: false))
                    userInput = ""  // 清空用戶輸入
                }
            } else {
                print("無法解析回應數據")
                DispatchQueue.main.async {
                    chatGPTResponse = "對方未回應"
                }
            }
        }.resume()
    }
    
    // 獲取當前時間的函數
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }
}

// 定義 OpenAI API 回應的資料結構
struct ChatGPTResponse: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

// 添加 PreviewProvider
struct ChatGPTView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTView()  // 不需要傳入參數
    }
}
